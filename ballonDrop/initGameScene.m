//
//  initGameScene.m
//  ballonDrop
//
//  Created by yaduan on 13-3-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.


#import "initGameScene.h"
#import "touchEvents.h"
#import "randomOperand.h"
#import "restartGame.h"
#import "Shared.h"
#import "getGameTime.h"
#import "operatorType.h"
#import "getTag.h"
#import "encourage.h"
#import "record.h"
#import "selectScene.h"
#import "CGPointExtension.h"

#define RESTITUTION_CONSTANT (0.75) //弹性系统的

@interface initGameScene ()

@property (nonatomic, copy) NSString *dataStr;
@end
@implementation initGameScene

@synthesize resultSprite;
@synthesize dataStr = _dataStr;
+(CCScene *)scene
{
    DebugMethod();
    CCScene *scene = [CCScene node];
    initGameScene *layer = [initGameScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    DebugMethod();
    if(self = [super init])
    {
        nextTossTime = CACurrentMediaTime();
        sharedArray = [Shared shared];
        sharedArray.FLAG = -1;
        sharedArray.totalQuesNum = 0;
        sharedArray.doRightNum = 0;
        sharedArray.dateArray = [[NSMutableArray alloc] init];
        
        sharedArray.allOpeSpriteArray = [CCArray arrayWithCapacity:5];   //这里面存的是3个操作数和两个符号
        [randomOperand getOperateType];
        [self initResultSprite];
        [self initThreeOpeNumSprite];
        [self initAddSubMutilDevSprite];
        [self initPauseStartSprite];
        [self initScoreTitle];
        [self initScore];
        [self initTimeLimit];
        
        touchEvents *touch = [touchEvents node];
        [self addChild:touch z:2];
        [self scheduleUpdate];
    }
    return self;
}

//制作精灵
-(CCSprite *)makeSprite:(NSString *)sprite:(NSString *)numString:(NSString *)fontName:(NSInteger)size:(ccColor3B)color:(CGRect)rect:(CGPoint)position
{
    CCSprite *opeSprite= [CCSprite spriteWithFile:sprite];
    CCLabelTTF* label = [CCLabelTTF labelWithString:numString fontName:fontName fontSize:size];
    CCSprite *sprt = [CCSprite spriteWithTexture:label.texture rect:rect];
    sprt.position = position;
    sprt.color = color;
    sprt.anchorPoint = CGPointMake(0.5,0.5);
    [opeSprite addChild:sprt];
    return opeSprite;
}

//调用制作精灵的函数，为了方便在别的函数中调用方便
+(id)callmakeSprite:(NSString *)sprite:(NSString *)numString:(NSString *)fontName:(NSInteger)size:(ccColor3B)color:(CGRect)rect:(CGPoint)position
{
    DebugMethod();
    return [[self alloc]makeSprite:sprite :numString :fontName :size :color : rect :position];
}

-(void)initThreeOpeNumSprite             //初始化操作数精灵
{
    DebugMethod();
    for(int i = 0 ; i<3;i++)
    {
        //这里是randomOperand文件生成的数组，只用更改sharedArray.resultAndOperateArray这个数组就万事Ok了
        NSNumber *num = [sharedArray.resultAndOperateArray objectAtIndex:i+1];
        NSString *numString = [NSString stringWithFormat:@"%@", num];
        CCSprite *ballon = [CCSprite spriteWithFile:@"balloon.png"];
        ccColor3B color = ccc3(125, 255, 255);
        CGPoint spritePosition = CGPointMake(ballon.contentSize.width/2+7,ballon.contentSize.height/2+20);
        ballon= [self makeSprite:@"balloon.png" :numString :@"Arial":35 :color:CGRectMake(0,0,64,32) :spritePosition];
        ballon.position = CGPointMake(arc4random()%1200,-[ballon texture].contentSize.height);
        [self addChild:ballon z:1 tag:i+1];
        [sharedArray.allOpeSpriteArray addObject:ballon];                //将组合成功的气球放入sharedArray.allOpeSpriteArray中，表示上升的气球总数
    }
}

-(void)initAddSubMutilDevSprite    //初始化加减乘除精灵
{
    DebugMethod();
    for(int i=0;i<2;i++)
    {
        CCSprite *sprite;
        NSString *labelString;
        CGPoint  spritePosition;
        CGRect   labelPosition;
        NSInteger size;
        ccColor3B color;
        if([getTag getoperateTag] == 0)
        {
            color = ccc3(125, 0, 255);
            labelString = @"66.png";
            sprite = [CCSprite spriteWithFile:@"66.png"];
             spritePosition = CGPointMake(sprite.contentSize.width/2+18,sprite.contentSize.height/2-8);
            labelPosition = CGRectMake(0,0,64,64);
            size = 50;
        } else if([getTag getoperateTag] == 1)
        {
            color = ccc3(125, 125, 125);
            labelString = @"11.png";
            sprite = [CCSprite spriteWithFile:@"11.png"];
            spritePosition = CGPointMake(sprite.contentSize.width/2+18,sprite.contentSize.height/2+2);
            labelPosition = CGRectMake(0,0,64,32);
            size = 67;
        }
         NSString *numString = [[operatorType getOperatorType] objectAtIndex:i];
        CCSprite *opeSprite= [self makeSprite:labelString :numString :@"Arial":size:color:labelPosition :spritePosition];
        opeSprite.position = CGPointMake(350*(i+1)+[sprite texture].contentSize.width,[sprite texture].contentSize.height+200*(i+1));
        [self addChild:opeSprite z:1 tag:i+4];
        [sharedArray.allOpeSpriteArray addObject:opeSprite];
    }
}

-(void)initResultSprite          //初始化结果数精灵
{
    DebugMethod();
    resultSprite = [CCSprite spriteWithFile:@"88.png"];
    CGPoint spritePosition = CGPointMake(resultSprite.contentSize.width/2-11,resultSprite.contentSize.height/2+8);
    NSNumber *resultNum = [sharedArray.resultAndOperateArray objectAtIndex:0];
    NSString *resultString = [NSString stringWithFormat:@"%@",resultNum];
    ccColor3B color = ccc3(125, 255, 255);
    resultSprite= [self makeSprite:@"88.png" :resultString :@"Arial":70 :color:CGRectMake(0,0,75,70) :spritePosition];
    resultSprite.position = CGPointMake([resultSprite texture].contentSize.width/2-5,
                                        [resultSprite texture].contentSize.height/2);
    [self addChild:resultSprite z:1 tag:0];
    
}

-(void)initPauseStartSprite    //初始化暂停开始精灵
{
    DebugMethod();
    CGSize size = [[CCDirector sharedDirector]winSize];
    CGPoint spritePosition = CGPointMake(resultSprite.contentSize.width/2-26,resultSprite.contentSize.height/2-8);
    CGRect labelPosition = CGRectMake(0,0,60,35);
    ccColor3B color = ccc3(125, 255, 255);
    CCSprite *pauseSprite= [self makeSprite:@"balloon.png" :@"暂停" :@"Arial":30 :color:labelPosition :spritePosition];
    CCSprite *startSprite= [self makeSprite:@"balloon1.png" :@"暂停" :@"Arial":30 :color:labelPosition :spritePosition];
    CCSprite *endSprite= [self makeSprite:@"balloon.png" :@"退出" :@"Arial":30 :color:labelPosition :spritePosition];
    CCSprite *endSprite_= [self makeSprite:@"balloon1.png" :@"退出" :@"Arial":30 :color:labelPosition :spritePosition];
    CCMenuItemSprite *pauseButton =[CCMenuItemSprite itemWithNormalSprite:pauseSprite
                                                           selectedSprite:startSprite
                                                                   target:self
                                                                 selector:@selector(pauseScene)];
    CCMenuItemSprite *endButton =[CCMenuItemSprite itemWithNormalSprite:endSprite
                                                         selectedSprite:endSprite_
                                                                 target:self
                                                               selector:@selector(resultScene)];
    pauseButton.position = ccp(size.width*0.05,size.height-70);  //以后这里要自己设定图片和位置
    endButton.position = ccp(size.width-[[endSprite texture]contentSize].width/2, size.height-70);
    CCMenu *menu = [CCMenu menuWithItems:pauseButton,endButton,nil];
    menu.position = CGPointZero;
    [self addChild:menu z:2];
}

-(void)pauseScene
{
    DebugMethod();
    [restartGame gameRestart:self];
}

-(void)resultScene
{
    DebugMethod();
     [self GetRecord];
     [self saveGameData:_dataStr saveFileName:@"duanduan"];
     [self loadGameData:@"duanduan"];
    [self stopAllAction];
     record *rec = [[record alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 750, 500)];
     [rec setCenter:CGPointMake(490.0f, -140.0f)];
     [rec  presentView];
     [[[CCDirector sharedDirector] view] addSubview:rec];
}

-(void)stopAllAction
{
    DebugMethod();
    for (int i = 0; i < [sharedArray.allOpeSpriteArray count]; i++) {
        CCSprite *spider = [sharedArray.allOpeSpriteArray objectAtIndex:i];
        [spider stopAllActions];
    }
}

-(void)initScoreTitle
{
    DebugMethod();
    CCLabelTTF *totalQueTitle = [CCLabelTTF labelWithString:@"totalQueNum: " fontName:@"Marker Felt"fontSize:25];
    CCLabelTTF *doRightTitle = [CCLabelTTF labelWithString:@"doRightNum: " fontName:@"Marker Felt" fontSize:25];
    
    totalQueTitle.position = ccp(80, 600);
    doRightTitle.position = ccp(80,530);
    [self addChild:totalQueTitle];
    [self addChild:doRightTitle];
}

-(void)initScore
{
    DebugMethod();
    NSNumber *total = [NSNumber numberWithInt:sharedArray.totalQuesNum];
    NSNumber *right = [NSNumber numberWithInt:sharedArray.doRightNum];
    NSString *totalString = [NSString stringWithFormat:@"%@", total];
    NSString *rightString = [NSString stringWithFormat:@"%@", right];
    totalQue = [CCLabelTTF labelWithString:totalString fontName:@"Georgia-BoldItalic" fontSize:28];
    doright =  [CCLabelTTF labelWithString:rightString fontName:@"Georgia-BoldItalic" fontSize:28];
    totalQue.position = ccp(100, 570);
    doright.position = ccp(100,500);
    [self addChild:totalQue];
    [self addChild:doright];
}

-(void)initTimeLimit
{
    DebugMethod();
    CGSize size = [[CCDirector sharedDirector]winSize];
    //这里以后要加个背景图片
    timeLimit = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:48];
    timeLimit.position = CGPointMake(size.width - 50,100);
    timeLimit.anchorPoint = CGPointMake(0.5, 0.5);
    [self addChild:timeLimit z:1];
}

-(void)GetRecord         //这一部分是用于点击END按钮后在小画板上显示的
{
    DebugMethod();
    NSString *totalTimeString,*getDateString;
    CCArray *weekArray = [CCArray arrayWithCapacity:7];
    [weekArray addObject:@"星期日"];
    [weekArray addObject:@"星期一"];
    [weekArray addObject:@"星期二"];
    [weekArray addObject:@"星期三"];
    [weekArray addObject:@"星期四"];
    [weekArray addObject:@"星期五"];
    [weekArray addObject:@"星期六"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger week = [comps weekday]-1;        
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    [comps release];
    if (hour == 12)
    {
        getDateString= [NSString  stringWithFormat:@"%4d年%d月%d日            %@            下午%d:",year,month,day,[weekArray objectAtIndex:week],hour];
    }
    else if(hour>12)
    {
        hour = hour-12;
        getDateString= [NSString  stringWithFormat:@"%4d年%d月%d日            %@            下午%d:",year,month,day,[weekArray objectAtIndex:week],hour];
    }
    else 
    {
        getDateString= [NSString  stringWithFormat:@"%4d年%d月%d日            %@            上午%d:",year,month,day,[weekArray objectAtIndex:week],hour];
    }
    if(min<10)
    {
        if(min == 0)
        {
            totalTimeString = [getDateString stringByAppendingFormat:@"00"];
        }
        else
        {
            NSString *zero = [getDateString stringByAppendingFormat:@"0"];
            totalTimeString = [zero stringByAppendingFormat:@"%d",min];
        }
    }
    else
    {
        totalTimeString = [getDateString stringByAppendingFormat:@"%d",min];
    }
    
    NSNumber *numTotal = [NSNumber numberWithInt:sharedArray.totalQuesNum];
    NSNumber *numRight = [NSNumber numberWithInt:sharedArray.doRightNum];
    NSString *totalString = [NSString stringWithFormat:@"                         %@                               ", numTotal];
    NSString *rightString = [NSString stringWithFormat:@"%@\n", numRight];
    
    totalTimeString = [totalTimeString stringByAppendingString:totalString];
    totalTimeString = [totalTimeString stringByAppendingString:rightString];
    [sharedArray.dateArray addObject:totalTimeString];
    self.dataStr = totalTimeString;
}

-(BOOL) saveGameData:(NSString *)data  saveFileName:(NSString *)fileName
{
    DebugMethod();
    NSError *error = nil;
    BOOL isOK = YES;
    //下面这两行是获得存放文件的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory)
    {
        NSLog(@"Documents directory not found!");
        return NO;
    }
    //将你要创建的文件夹连接到documentsDirectory这个路径上，但注意这里并没有创建
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:appFile];
    //这里一定要做一个判断，判断这个文件是否存在，如果已经存在但没有判断，直接来创建，那
    //这一次运行程序的文件会将上一次的文件覆盖掉，丢失以前的数据
    if(isDirExist == NO)
    {
        //createDirectoryAtPath:真正的创建一个文件夹
        [[NSFileManager defaultManager]createDirectoryAtPath:appFile withIntermediateDirectories:YES attributes:nil error:&error];
    }
    //将你要创建的文件连接到上面创建的文件夹的路径上，注意这里并没有创建
    //如果你并不想创建文件夹想直接创建文件，上面关于appFile的东西就可以删掉了
    //只要把下面的appFile改为documentsDirectory就可以了
    NSString *logPath = [appFile stringByAppendingPathComponent:@"file.txt"];
    BOOL isFileExist = [[NSFileManager defaultManager]fileExistsAtPath:logPath];
    if(isFileExist == NO)
    {
       [[NSFileManager defaultManager] createFileAtPath:logPath contents:nil attributes:nil];
    }
    
    //下面的NSFileHandle是向文件中写数据
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logPath];
    
    @try
    {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    }
    @catch (NSException *exception)
    {
        isOK = NO;
    }
    @finally{
    }
    //关闭文件
    [fileHandle closeFile];
    return isOK;
}

//读取游戏数据
//参数介绍：
//   (NSString *)fileName ：需要读取数据的文件名
-(id) loadGameData:(NSString *)fileName
{
    DebugMethod();
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSString *logPath = [appFile stringByAppendingPathComponent:@"file.txt"];
    //路径
   //NSMutableArray *myData = [[[[NSMutableArray alloc] initWithContentsOfFile:logPath] componentsJoinedByString:@"\n"] autorelease];
    NSString *ss = [NSString stringWithContentsOfFile:logPath encoding:NSUTF8StringEncoding error:&error];
    sharedArray.recordDataArray = [ss componentsSeparatedByString:@"\n"];
    return sharedArray.recordDataArray;
}

-(void) update: (ccTime) dt
{
    DebugMethod();
    [self resetAllSprite];
    [self getTimeLimit];
   // [self checkForCollision];
}

-(void)getTimeLimit      //这里表示的是10秒倒计时
{
    DebugMethod();
    [timeLimit setString:[NSString stringWithFormat:@""]];
    double curTime = CACurrentMediaTime();
    for(int time=curTime;time<nextTossTime+[getGameTime getTheSetTime];time++)
    {
        remainTime =(int)(nextTossTime+[getGameTime getTheSetTime]- curTime);
        if(remainTime<10||remainTime == 10)
        {
            [timeLimit setString:[NSString stringWithFormat:@"%i",remainTime]];
            remainTime--;
            if(remainTime<0)
            {
                [timeLimit setString:[NSString stringWithFormat:@"0"]];
            }
        }
    }
}

-(void)resetAllSprite
{
    DebugMethod();
    for(int i=0;i<[sharedArray.allOpeSpriteArray count];i++)
    {
        CCSprite *ballon = [sharedArray.allOpeSpriteArray objectAtIndex:i];
        if([ballon numberOfRunningActions]==0)
        {
            [self makeBallonPositionRandom:ballon];
        }
    }
    // [self checkForCollision];
    double curTime = CACurrentMediaTime();
    for(int time=curTime;time<nextTossTime+[getGameTime getTheSetTime];time++)
    {
        if(sharedArray.FLAG == 1)
        {                  
            [resultSprite removeFromParentAndCleanup:YES]; //表示更新镜子里的结果数
            [randomOperand getOperateType];                //得到运算类型和操作数
            [self initResultSprite];                       //得到结果数
            [self getEncourage];                           //得到鼓励
            sharedArray.FLAG = -1;
            nextTossTime = curTime;
            break;
        }
        else if (sharedArray.FLAG == 0)
        {
             sharedArray.FLAG = -1;
        }
        if(curTime>nextTossTime+[getGameTime getTheSetTime])
        {
            sharedArray.totalQuesNum ++;
            
            
            for(CCSprite *sprite in sharedArray.allOpeSpriteArray)
            {
                CCParticleSystemQuad *starboom = [CCParticleSystemQuad particleWithFile:@"startboom.plist"];
                starboom.position = sprite.position;
                [self addChild:starboom];
                
                [sprite removeFromParentAndCleanup:YES];
            }
            
            
            [sharedArray.allOpeSpriteArray removeAllObjects];
            [resultSprite removeFromParentAndCleanup:YES]; //表示更新镜子里的结果数
            [randomOperand getOperateType];                //得到运算的类型和操作数
            [self initResultSprite];                       //得到结果数
            [self scheduleOnce:@selector(createNextThreeOpeNumAddSubMutilDevSprite) delay:0.2];
            nextTossTime = curTime;
        }
    }
    [self removeChild:totalQue cleanup:YES];
    [self removeChild:doright cleanup:YES];
    [self initScore];
}

-(void)createNextThreeOpeNumAddSubMutilDevSprite
{
    DebugMethod();
    [self initThreeOpeNumSprite];
    [self initAddSubMutilDevSprite];
}

-(void)makeBallonPositionRandom:(id)sender
{
    DebugMethod();
    CCSprite *sprite = (CCSprite *)sender;
    CGSize size = [[CCDirector sharedDirector]winSize];
    CGPoint position = CGPointMake(size.width*CCRANDOM_0_1()-sprite.contentSize.width/2, size.height*CCRANDOM_0_1()-sprite.contentSize.width/2);
    if(position.x<sprite.contentSize.width/2)
    {
        position.x = sprite.contentSize.width/2;
    }
    if(position.y<sprite.contentSize.height/2)
    {
        position.y = sprite.contentSize.height/2;
    }
    float time = ccpDistance(position, sprite.position)/speed;
    
    id actions = [CCMoveTo actionWithDuration:time position:position];
    [sprite runAction:actions];
}

-(void)getEncourage
{
    DebugMethod();
    sharedArray.doRightNum++;
    sharedArray.totalQuesNum ++;
    
    if(sharedArray.doRightNum== 5)
    {
        encourage *encou = [encourage node];
        [self addChild:encou z:1];
        [self scheduleOnce:@selector(createNextThreeOpeNumAddSubMutilDevSprite) delay:1.7];
    }
    else if (sharedArray.doRightNum == 15)
    {
        encourage *encou = [encourage node];
        [self addChild:encou z:1];
        [self scheduleOnce:@selector(createNextThreeOpeNumAddSubMutilDevSprite) delay:2.7];
    }
    else if(sharedArray.doRightNum>=20 && sharedArray.doRightNum%10 == 0)
    {
        encourage *encou = [encourage node];
        [self addChild:encou z:1];
        [self scheduleOnce:@selector(createNextThreeOpeNumAddSubMutilDevSprite) delay:1.3];
    }
    else
    {
        [self scheduleOnce:@selector(createNextThreeOpeNumAddSubMutilDevSprite) delay:0.2];
    }
}

//-(void) checkForCollision
//{
//    for(int i =0;i<[sharedArray.allOpeSpriteArray count];i++)
//    {
//        CCSprite *ballon = [sharedArray.allOpeSpriteArray objectAtIndex:i];
//        for(int j = i+1 ; j<[sharedArray.allOpeSpriteArray count];j++)
//        {
//            CCSprite *ballon1 = [sharedArray.allOpeSpriteArray objectAtIndex:j];
//            if([self iscollision:ballon:ballon1])
//            {
//                [self resolveCollision:ballon :ballon1];
//            }
//        }
//    }
//}

-(BOOL)iscollision:(CCSprite *)balloon:(CCSprite *)balloon1
{
    DebugMethod();
    float distance = ccpDistance(balloon.position, balloon1.position);
    float dis = (balloon.position.x - balloon1.position.x)*(balloon.position.x - balloon1.position.x)+(balloon.position.y - balloon1.position.y)*(balloon.position.y - balloon1.position.y);
    if(distance*distance<=dis)
    {
        return true;
    }
    return false;
}

-(void)resolveCollision:(CCSprite *)balloon:(CCSprite *)balloon1
{
    DebugMethod();
    CGPoint direction = ccpSub(balloon.position, balloon1.position);
    float d = ccpLength(direction);
    float dis = (balloon.position.x - balloon1.position.x)*(balloon.position.x - balloon1.position.x)+(balloon.position.y - balloon1.position.y)*(balloon.position.y - balloon1.position.y);
 //   float distance = ccpDistance(balloon.position, balloon1.position);
    //下面这一点不对，一会还要改
    CGPoint targetPos = ccpMult(direction,(sqrt(dis)-d)/d);
    float im1 = 1/12.56637;
    float im2 = 1/12.56637;
    balloon.position = ccpAdd(balloon.position,ccpMult(targetPos, (im2/(im1+im2))));
    balloon1.position = ccpSub(balloon1.position, ccpMult(targetPos, (im2 / (im1 + im2))));
    
    CGPoint v = CGPointMake(-4.31141639,-24.8381977);
    float vn = ccpDot(v,ccpNormalize(targetPos));
    if (vn>0.0f)  return;
    float i = (-(1.0f+0.75)*vn)/(12.56637+12.56637);
    CGPoint impulse = ccpMult(targetPos, i);
}

-(void) pathMove:(CCSprite*) sprite
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    double randX = arc4random()% (int)(size.width +50);
    double randY = arc4random()% (int)(size.height +50);
    
    CGPoint start = sprite.position;
    CGPoint end=ccp(randX, randY);
    
    float finalDistance=ccpDistance(start, end);
//    float speedToMove = MIN_SPEED + arc4random()%(speed - MIN_SPEED);
    float durationToMove = finalDistance/speed;
    
    CCMoveTo *spawnAction = [CCMoveTo actionWithDuration:durationToMove * 6.0 position:ccp(randX,randY)];
    [sprite runAction:spawnAction];
}



////精灵碰撞
-(void) checkForCollision
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    for(int i =0;i<[sharedArray.allOpeSpriteArray count];i++)
    {
        CCSprite *ballon = [sharedArray.allOpeSpriteArray objectAtIndex:i];
        CGRect projectileRects = CGRectMake(ballon.position.x - (ballon.contentSize.width/2),
                                            ballon.position.y - (ballon.contentSize.height/2),
                                            ballon.contentSize.width,
                                            ballon.contentSize.height);
        for(int j = i+1 ; j<[sharedArray.allOpeSpriteArray count];j++)
        {
            CCSprite *ballon1 = [sharedArray.allOpeSpriteArray objectAtIndex:j];
//            while (1) {
//   
            CGRect targetRect = CGRectMake(ballon1.position.x - (ballon1.contentSize.width/2),
                                           ballon1.position.y - (ballon1.contentSize.height/2),
                                           ballon1.contentSize.width,
                                           ballon1.contentSize.height);
            
            if(CGRectIntersectsRect(projectileRects, targetRect))
            {
                CGPoint diff = ccpSub(ballon.position, ballon1.position);
                if(diff.x<0)
                {
//                    [self pathMove:ballon];
//                    [self pathMove:ballon1];
                    CGPoint velocityUp = CGPointMake(0, 30);
                    velocityUp = ccpAdd(ballon.position, velocityUp);
                    float time = ccpDistance(ballon.position,velocityUp)/speed;
                    id actions = [CCMoveTo actionWithDuration:time position:velocityUp];
                     [ballon runAction:actions];
                    
                    CGPoint velocityright = CGPointMake(30, 0);
                    velocityright = ccpAdd(ballon1.position, velocityright);
                    float time1 = ccpDistance(ballon1.position,velocityright)/speed;
                    id actions1 = [CCMoveTo actionWithDuration:time1 position:velocityright];
                    [ballon1 runAction:actions1];
                }
                else
                {
//                    [self pathMove:ballon];
//                    [self pathMove:ballon1];
                    CGPoint velocityUp = CGPointMake(0, 30);
                    velocityUp = ccpAdd(ballon1.position, velocityUp);
                    float time1 = ccpDistance(ballon1.position,velocityUp)/speed;
                    id actions1 = [CCMoveTo actionWithDuration:time1 position:velocityUp];
                    [ballon1 runAction:actions1];
                    
                    CGPoint velocityright = CGPointMake(30, 0);
                    velocityright = ccpAdd(ballon.position, velocityright);
                    float time = ccpDistance(ballon.position,velocityright)/speed;
                    id actions = [CCMoveTo actionWithDuration:time position:velocityright];
                    [ballon runAction:actions];

                }
               // [self makeBallonPositionRandom:ballon1];
            }
            else break;
            }
        }
    }

//                NSLog(@"balloon.tag = %d",ballon.tag);
//                NSLog(@"balloon1.tag = %d",ballon1.tag);
//                CGPoint diff = ccpSub(ballon.position, ballon1.position);
//                if(diff.x<0)
//                {
//                    CGPoint velocityUp = CGPointMake(0, 10);
//                    CGPoint velocityright = CGPointMake(10, 0);
//                    velocityUp = ccpAdd(ballon.position, velocityUp);
//                    velocityright = ccpAdd(ballon1.position, velocityright);
//                    
//                    float time = ccpDistance(ballon.position,velocityUp)/speed;
//                    
//                    id actions = [CCMoveTo actionWithDuration:time position:velocityUp];
//                    [ballon runAction:actions];
//
//                    id actions1 = [CCMoveTo actionWithDuration:time position:velocityright];
//                    [ballon1 runAction:actions1];

//                    CGPoint position = CGPointMake(size.width*CCRANDOM_0_1()-ballon.contentSize.width/2, size.height*CCRANDOM_0_1()-ballon.contentSize.width/2);
//                    if (position.x<ballon.position.x)
//                    {
//////                        ballon.position = position;
//                        float time = ccpDistance(position, ballon.position)/speed;
//
//                        id actions = [CCMoveTo actionWithDuration:time position:position];
//                        [ballon runAction:actions];
//                    }
//                    else if (ballon1.position.x<position.x)
//                    {
////                        ballon1.position = position;
//                        float time = ccpDistance(position, ballon1.position)/speed;
//                        
//                        id actions = [CCMoveTo actionWithDuration:time position:position];
//                        [ballon1 runAction:actions];
//                    }
//                }
//                else
//                {
//                    CGPoint velocityUp = CGPointMake(0, 10);
//                    CGPoint velocityright = CGPointMake(10, 0);
//                    velocityUp = ccpAdd(ballon.position, velocityright);
//                    velocityright = ccpAdd(ballon1.position, velocityUp);
//                    
//                    float time = ccpDistance(ballon.position,velocityUp)/speed;
//                    
//                    id actions = [CCMoveTo actionWithDuration:time position:velocityUp];
//                    [ballon1 runAction:actions];
//                    
//                    id actions1 = [CCMoveTo actionWithDuration:time position:velocityright];
//                    [ballon runAction:actions1];
//                    
//                    CGPoint position = CGPointMake(size.width*CCRANDOM_0_1()-ballon.contentSize.width/2, size.height*CCRANDOM_0_1()-ballon1.contentSize.width/2);
//                    if (position.x>ballon.position.x)
//                    {
//                        float time = ccpDistance(position, ballon.position)/speed;
//                        
//                        id actions = [CCMoveTo actionWithDuration:time position:position];
//                        [ballon runAction:actions];
//                    }
//                    else if (ballon1.position.x>position.x)
//                    {
//                        float time = ccpDistance(position, ballon1.position)/speed;
//                        
//                        id actions = [CCMoveTo actionWithDuration:time position:position];
//                        [ballon1 runAction:actions];
//                    }
//
//                }
//                    float distance = ccpDistance(ballon.position, ballon1.position);
//                //ballon.position = ccpAdd(ballon.position,);
//                CGPoint direction = ccpSub(ballon1.position, ballon.position);
//                CGPoint targetPos = ccpAdd(ballon.position, ccpMult(ccp(direction.x/distance, direction.y/distance),[ballon texture].contentSize.width));
//                [ballon1 stopAllActions];
//                id action = [CCMoveTo actionWithDuration:0.1 position:targetPos];
//                [ballon1 runAction:action];
//            }
//        }
//        }
//    }
//}

//        - (void)update:(ccTime)dt {
//            
//            
//            
//            CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2),
//                                               projectile.position.y - (projectile.contentSize.height/2),
//                                               projectile.contentSize.width,
//                                               projectile.contentSize.height);
//            
//            //CGRectMake(0,220,320,50);
//            CGRect targetRects =  CGRectMake(_monkey.position.x - (_monkey.contentSize.width/2),
//                                             _monkey.position.y - (_monkey.contentSize.height/2),
//                                             _monkey.contentSize.width,
//                                             _monkey.contentSize.height);
//            
//            if (CGRectIntersectsRect(projectileRect, targetRects)) {
//                NSLog(@"ha ha Collision detected"); 
//            }
//        
//    }
    //    float ballonSize = [[sharedArray.allOpeSpriteArray lastObject] texture].contentSize.width;
    //    float ballonCollisionRadius = ballonSize * 0.4f;
    //    float maxCollisionDistance = ballonCollisionRadius + ballonCollisionRadius;
    //    CCSprite* ballon = [sharedArray.allOpeSpriteArray objectAtIndex:[sharedArray.allOpeSpriteArray count]*CCRANDOM_0_1()];
    //    CCSprite *ballon1 = [sharedArray.allOpeSpriteArray objectAtIndex:[sharedArray.allOpeSpriteArray count]*CCRANDOM_0_1()];
    //
    //    float distance = ccpDistance(ballon.position, ballon1.position);
    //    if (distance < maxCollisionDistance)
    //    {
    //        [ballon stopAllActions];
    //        [ballon1 stopAllActions];
    //        CGPoint moveDir = ccpSub(ballon1.position, ballon.position);
    //        CGPoint targetPos = ccpAdd(ballon1.position, ccpMult(ccp(moveDir.x/distance, moveDir.y/distance),10));
    //        id action  = [CCMoveTo actionWithDuration:0.2 position:targetPos];
    //        [ballon runAction:action];
    //       // [ballon1 runAction:action];
    //      //  [self resetBallon:ballon];
    //      //  [self resetBallon:ballon];
    //    }
//}

#pragma mark - Deallocation

-(void)dealloc
{
    CCLOG(@"%@,%@",NSStringFromSelector(_cmd),self);
    [self removeFromParentAndCleanup:YES];
    [resultSprite release];
    resultSprite = nil;
    [super dealloc];
}



@end
