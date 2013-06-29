//
//  touchEvents.m
//  ballonDrop
//
//  Created by yaduan on 13-3-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "touchEvents.h"
#import "CCBlade.h"
#import "Shared.h"
#import "randomOperand.h"
#import "initGameScene.h"
#import "restartGame.h"
#import "getTag.h"
#import "operatorType.h"
#import "encourage.h"


@implementation touchEvents

@synthesize swoosh;
@synthesize ballonarray;
@synthesize numArray;
@synthesize cutBallonArray;

-(id)init
{

   if(self = [super init])
   {
       DebugMethod();
       sharedArray = [Shared shared];
       sharedArray.FLAG = -1;
       sharedArray.doRightNum = 0;
       sharedArray.totalQuesNum = 0;
       cutBallonArray = [[CCArray alloc]initWithCapacity:5];   //这里必需用initWithCapacity
       self. isTouchEnabled = YES;   //激活层的touch事件
       deltaRemainder = 0.0;         //用于粒子
     
       CCParticleSystemQuad *sunPollen = [CCParticleSystemQuad particleWithFile:@"sun_pollen.plist"];
       [self addChild:sunPollen];
       blades = [[CCArray alloc]initWithCapacity:10];  //这里必需用initWithCapacity  不用会崩溃  以后要看看为什么
       CCTexture2D *texture = [[CCTextureCache sharedTextureCache]addImage:@"streak.png"];
       for (int i = 0; i < 10; i++)
       {
           //CCBlade有一个由点组成的path（路径）数组，并穿过这些点绘制一个纹理直线。目前它是在draw方法中更新的这个数组。不过，一种更推荐的方
           //式是只在draw方式中绘制，其他的内容放到update方法中去。
           //创建了3个在游戏中公用的CCBlade对象，对每一个blade，设置最大的点个数为50来防止轨迹太长，并设置
           //blade的纹理为Resources文件夹中的streak
           CCBlade *eachBlade = [CCBlade bladeWithMaximumPoint:50];
           //设置每个blade的autoDim变量为NO，CCblade使用术语“Dim”来说明此blade会自动从尾巴到头的渐变消失
           //CCBlade自动从path数组中移除这些点
           eachBlade.autoDim = YES;
           eachBlade.texture = texture;
           [self addChild:eachBlade z:2];
           [blades addObject:eachBlade];
       }
       //添加粒子效果
       bladeSparkle = [CCParticleSystemQuad particleWithFile:@"blade_sparkle.plist"];
       [bladeSparkle stopSystem];
       [self addChild:bladeSparkle z:2];
       timeCurrent = 0;
       timePrevious = 0;
       [self scheduleUpdate];
   }
   return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        DebugMethod();
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector]convertToGL:location];
       // startPoint = location;
       // endPoint = location;
        CCBlade *bladeInBlades;
        CCARRAY_FOREACH(blades, bladeInBlades)
        {
            if (bladeInBlades.path.count == 0)
            {
                blade = bladeInBlades;
                [blade push:location];
                break;
            }
        }
        //刀片上环绕着星星  粒子效果
        bladeSparkle.position = location;
        [bladeSparkle resetSystem];
    }
}

int i = 0,j = 0;
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        //得到触摸屏上的点
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        //定义一个点，并把location赋值给point，为了在下面的代码执行中，不改变locaion的值
        CGPoint point = [[CCDirector sharedDirector] convertToGL: location];
     //   point = location;
    
        //遍历精灵数组中的精灵
        for(CCSprite *ballon in sharedArray.allOpeSpriteArray)
        {
             int flag = 0;
             CGRect rect = [ballon textureRect];
             //rect = CGRectMake(0, 0, ballon.contentSize.width/2, ballon.contentSize.height/2);
            rect = CGRectMake(-rect.size.width/2, -rect.size.height/2, rect.size.width, rect.size.height);
            point = [ballon convertTouchToNodeSpaceAR:touch];
             if(CGRectContainsPoint(rect,point))
             {
                 i++;
                 ballon.color = ccc3(255, 125, 0);
                 if(i==1)
                 {
                     [cutBallonArray addObject:ballon];
                     break;       
                 }
                 else if(i>1)
                 {
                     for(CCSprite *sprite in cutBallonArray)
                     {
                         if(ballon.tag == sprite.tag)
                         {
                             flag = 1;
                             break;
                         }
                     }
                     if(flag == 0)
                     {
                         [cutBallonArray addObject:ballon];
                         break;
                     }
                 }
             }
        }
       
        //跟随触摸设置最后的点的坐标
        endPoint = location;                             
        [blade push:location];   //出现刀片
        
        //星星粒子效果跟随着触摸点
        bladeSparkle.position = location;
        
        //计算播放时间
        ccTime deltaTime = timeCurrent - timePrevious;  
        timePrevious = timeCurrent;
        //触摸过的点的坐标为了下面的计算
        CGPoint oldPosition = bladeSparkle.position;
        
        bladeSparkle.position = location;
        
        //如果划屏的速度超过了1000 就播放音乐
        if (ccpDistance(bladeSparkle.position, oldPosition) / deltaTime > 1000)
        {
            if (!swoosh.isPlaying)
            {
                //播放音乐
                [swoosh play];       
            }
        }
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches )
    {
        // 褪去叶片
        [blade dim:YES];             
        //划到最后使星星消失
        [bladeSparkle stopSystem];
	}
    [self calculate];
}

-(void) update: (ccTime) dt
{
    if ([blade.path count] > 3)
    {
        deltaRemainder+=dt*60*1.2;
        int pop = (int)roundf(deltaRemainder);
        deltaRemainder-=pop;
        [blade pop:pop];
    }
    timeCurrent += dt;
}

-(void)calculate
{
    int flag = 0,index,result,count = 0;
    CCArray *tagArray = [CCArray arrayWithCapacity:2];
    if([cutBallonArray count]!=3)                       //第一步 判断选中的精灵是否小于3
    {
        flag = 0;
    }
    else
    {
        for(int i = 0 ; i<[cutBallonArray count];i++)   //第二步 ，选中的精灵等于3 判断是否有两个符号
        {
            CCSprite *sprite = [cutBallonArray objectAtIndex:i];
            if(sprite.tag>3)
            {
                count++;
                index = i;
            }
            else
            {
                int tag = sprite.tag;
                [tagArray addObject:[NSNumber numberWithInt:tag]];
            }
        }
        if(count == 1)                                  //第三步 选中的精灵是否有一个符号
        {
                CCSprite *sprite = [cutBallonArray objectAtIndex:index];
                int tag1 = [[tagArray objectAtIndex:0] intValue];
                int tag2 = [[tagArray objectAtIndex:1]intValue];
                int operationNum1 = [[sharedArray.resultAndOperateArray objectAtIndex:tag1] intValue];
                int operationNum2 = [[sharedArray.resultAndOperateArray objectAtIndex:tag2] intValue];
                if(sprite.tag == 4)
                {
                    if([[[operatorType getOperatorType] objectAtIndex:0] isEqualToString:@"+"])
                    {
                        result = operationNum1+operationNum2;
                    }
                    if([[[operatorType getOperatorType] objectAtIndex:0] isEqualToString:@"*"])
                    {
                        result = operationNum1*operationNum2;
                    }
                }
                else if(sprite.tag == 5)
                {
                    if([[[operatorType getOperatorType] objectAtIndex:1] isEqualToString:@"-"])
                    { 
                        result = operationNum1-operationNum2;
                        if(result < 0)
                        {
                            result = 0-result;
                        }
                    }
                    if([[[operatorType getOperatorType] objectAtIndex:1] isEqualToString:@"/"])
                    {
                        if(operationNum1%operationNum2 == 0)
                        {
                            result = operationNum1/operationNum2;
                        }
                        else if (operationNum2%operationNum1 == 0)
                        {
                            result = operationNum2/operationNum1;
                        }
                    }
              }
             if(result == [[sharedArray.resultAndOperateArray objectAtIndex:0] intValue])
             {
                flag = 1;
             }
             else flag = 0;
        }
    }
    if(flag == 1)
    {
        for(CCSprite *sprite in sharedArray.allOpeSpriteArray)
        {
            CCParticleSystemQuad *starboom = [CCParticleSystemQuad particleWithFile:@"lihua.plist"];
            starboom.position = sprite.position;
            [self addChild:starboom];
            [sprite removeFromParentAndCleanup:YES];
         }
        [sharedArray.allOpeSpriteArray removeAllObjects];
        [cutBallonArray removeAllObjects];
        sharedArray.FLAG = 1;
    }
    else if(flag == 0)
    {
        for(CCSprite *sprite in cutBallonArray)
        {
            sprite.color = ccWHITE;
            CCParticleSystemQuad *starboom = [CCParticleSystemQuad particleWithFile:@"startboom.plist"];
            starboom.position = sprite.position;
            [self addChild:starboom];
        }
        [cutBallonArray removeAllObjects];
        sharedArray.FLAG = 0;
    }
}

-(void)dealloc
{
    CCLOG(@"%@,%@",NSStringFromSelector(_cmd),self);
    [swoosh release];
    [ballonarray release];
    [numArray release];
    [cutBallonArray release];
    [blades release];
    blades = nil;
    swoosh = nil;
    ballonarray = nil;
    numArray = nil;
    cutBallonArray = nil;
    [super dealloc];
}

@end
