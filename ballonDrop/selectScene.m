//
//  selectScene.m
//  ballonDrop
//
//  Created by yaduan on 13-3-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.


//http://www.xuanyusong.com/archives/1878  参考地点

#import "selectScene.h"
#import "makeNewSprite.h"
#import "initGameScene.h"

@implementation selectScene

@synthesize Icon;
@synthesize moveAction;
@synthesize walkAction;

@synthesize spriteAdd = _spriteAdd;
@synthesize spriteMult= _spriteMult;
@synthesize spriteTen= _spriteTen;
@synthesize spriteTwenty= _spriteTwenty;
@synthesize spriteThirty= _spriteThirty;
@synthesize spriteFifty= _spriteFifty;
@synthesize spriteHundred= _spriteHundred;
@synthesize spriteReset= _spriteReset;
@synthesize spriteOK= _spriteOK;

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    selectScene *layer = [selectScene node];
    [scene addChild: layer];
     return scene;
}

-(void)bearMoveEnded
{
    [Icon stopAction:walkAction];
    moving = FALSE;
}

-(id) init
{
    if( (self=[super init]) )
    {
        share = [Shared shared];
        allArray = [[CCArray alloc]initWithCapacity:5];
        share.jumpArray = [[CCArray alloc]initWithCapacity:3];
        self.isTouchEnabled = YES;
        
        CGSize winsize = [[CCDirector sharedDirector]winSize];
        
        
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        [background setPosition:ccp(winsize.width/2, winsize.height/2)];
        background.anchorPoint = ccp(0.5, 0.5);
        [self addChild:background z:-1];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"bee.plist"];
        
        //2) 创建一个精灵批处理结点
        CCSpriteBatchNode *beeAdd = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeAdd];
        CCSpriteBatchNode *beeMult = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeMult];
        CCSpriteBatchNode *beeTen = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeTen];
        CCSpriteBatchNode *beeTwenty = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeTwenty];
        CCSpriteBatchNode *beeThirty = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeThirty];
        CCSpriteBatchNode *beeFifty = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeFifty];
        CCSpriteBatchNode *beeHundred = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeHundred];
        CCSpriteBatchNode *beeReset = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeReset];
        CCSpriteBatchNode *beeOK = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:beeOK];

        //(3)创建CCSpriteBatchNode对象，把spritesheet当作参数传进去。收集帧列表
        NSMutableArray *walkAdd = [NSMutableArray array];
        NSMutableArray *walkMult = [NSMutableArray array];
        NSMutableArray *walkTen = [NSMutableArray array];
        NSMutableArray *walkTwenty = [NSMutableArray array];
        NSMutableArray *walkThirty = [NSMutableArray array];
        NSMutableArray *walkFifty = [NSMutableArray array];
        NSMutableArray *walkHundred = [NSMutableArray array];
        NSMutableArray *walkReset = [NSMutableArray array];
        NSMutableArray *walkOK = [NSMutableArray array];

        
        //为了创建一系列的动画帧，我们简单地遍历我们的图片名字（它们是按照XX1.png-->XX2.png的方式命名的），然后使用共享的CCSpriteFrameCache来获得每一个动画帧。记住，它们已经在缓存里了，因为我们前面调用了addSpriteFramesWithFile方法。
        for(int i = 1 ; i <= 6 ; i++ )
        { 
            [walkAdd addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"addsub%d.png",i]]];
            [walkMult addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"multdiv%d.png",i]]];
            [walkTen addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"beeTen%d.png",i]]];
            [walkTwenty addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"beeTwenty%d.png",i]]];
            [walkThirty addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"beeThirty%d.png",i]]];
            [walkFifty addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"beefifty%d.png",i]]];
            [walkHundred addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"beehundred%d.png",i]]];
            [walkReset addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"reset%d.png",i]]];
            [walkOK addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"ok%d.png",i]]];
        }
        
        //(4)创建动画对象
        CCAnimation *addWalkAnim = [CCAnimation animationWithSpriteFrames:walkAdd delay:0.2f];
        CCAnimation *multWalkAnim = [CCAnimation animationWithSpriteFrames:walkMult delay:0.2f];
        CCAnimation *tenWalkAnim = [CCAnimation animationWithSpriteFrames:walkTen delay:0.2f];
        CCAnimation *twentyWalkAnim = [CCAnimation animationWithSpriteFrames:walkTwenty delay:0.2f];
        CCAnimation *thirtyWalkAnim = [CCAnimation animationWithSpriteFrames:walkThirty delay:0.2f];
        CCAnimation *fiftyWalkAnim = [CCAnimation animationWithSpriteFrames:walkFifty delay:0.2f];
        CCAnimation *hundredWalkAnim = [CCAnimation animationWithSpriteFrames:walkHundred delay:0.2f];
        CCAnimation *resetWalkAnim = [CCAnimation animationWithSpriteFrames:walkReset delay:0.2f];
        CCAnimation *okWalkAnim = [CCAnimation animationWithSpriteFrames:walkOK delay:0.2f];
        
        self.addAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:addWalkAnim]];
        self.multAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:multWalkAnim]];
        self.tenAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:tenWalkAnim]];
        self.TwentyAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:twentyWalkAnim]];
        self.thirtyAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:thirtyWalkAnim]];
        self.fiftyAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:fiftyWalkAnim]];
        self.hundredAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:hundredWalkAnim]];
        self.resetAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:resetWalkAnim]];
        self.okAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:okWalkAnim]];
        
        
        self.spriteAdd = [CCSprite spriteWithSpriteFrameName:@"addsub1.png"];
        self.spriteMult = [CCSprite spriteWithSpriteFrameName:@"multdiv1.png"];
        self.spriteTen = [CCSprite spriteWithSpriteFrameName:@"beeTen1.png"];
        self.spriteTwenty = [CCSprite spriteWithSpriteFrameName:@"beeTwenty1.png"];
        self.spriteThirty = [CCSprite spriteWithSpriteFrameName:@"beeThirty1.png"];
        self.spriteFifty = [CCSprite spriteWithSpriteFrameName:@"beefifty1.png"];
        self.spriteHundred = [CCSprite spriteWithSpriteFrameName:@"beehundred1.png"];
        self.spriteReset = [CCSprite spriteWithSpriteFrameName:@"reset1.png"];
        self.spriteOK = [CCSprite spriteWithSpriteFrameName:@"ok1.png"];
        
        _spriteAdd.position = ccp(-[_spriteAdd textureRect].size.width/2,510);
        _spriteMult.position = ccp(-[_spriteMult textureRect].size.width/2, 310);
        _spriteTen.position = ccp(-300, 650);
        _spriteTwenty.position = ccp(-300, 550);
        _spriteThirty.position = ccp(-300,250);
        _spriteFifty.position = ccp(-300,85);
        _spriteHundred.position = ccp(-300,350);
        _spriteReset.position = ccp(10,300);
        _spriteOK.position = ccp(1024, 600);
        
        _spriteAdd.tag = 0;
        _spriteMult.tag = 1;
        _spriteTen.tag = 2;
        _spriteTwenty.tag = 3;
        _spriteThirty.tag = 4;
        _spriteFifty.tag = 5;
        _spriteHundred.tag = 6;
        _spriteReset.tag = 7;
        _spriteOK.tag = 8;
        
        [_spriteAdd runAction:_addAction];
        [_spriteMult runAction:_multAction];
        [_spriteTen runAction:_tenAction];
        [_spriteTwenty runAction:_twentyAction];
        [_spriteThirty runAction:_thirtyAction];
        [_spriteFifty runAction:_fiftyAction];
        [_spriteHundred runAction:_hundredAction];
        [_spriteReset runAction:_resetAction];
        [_spriteOK runAction:_okAction];
        
        id actionMove = [CCMoveTo actionWithDuration:10 position:CGPointMake(200, 400)];
        [_spriteTen runAction:[CCSequence actions:actionMove, nil]];
        id actionMove1 = [CCMoveTo actionWithDuration:10 position:CGPointMake(600, 410)];
        [_spriteTwenty runAction:[CCSequence actions:actionMove1, nil]];
        
        [beeAdd addChild:_spriteAdd];
        [beeMult addChild:_spriteMult];
        [beeTen addChild:_spriteTen];
        [beeTwenty addChild:_spriteTwenty];
        [beeThirty addChild:_spriteThirty];
        [beeFifty addChild:_spriteFifty];
        [beeHundred addChild:_spriteHundred];

//        [allArray addObject:_spriteAdd];     这里的allArray要按顺序来加载
//        [allArray addObject:_spriteMult];
        [allArray addObject:_spriteTen];
        [allArray addObject:_spriteTwenty];
//        [allArray addObject:_spriteThirty];
//        [allArray addObject:_spriteFifty];
//        [allArray addObject:_spriteHundred];
//        [allArray addObject:_spriteReset];
//        [allArray addObject:_spriteOK];

        
        //(5)接下来，我们通过传入sprite帧列表来创建一个CCAnimation对象，并且指定动画播放的速度。我们使用０.１来指定每个动画帧之间的时间间隔。 创建sprite并且让它run动画action
//        self.addAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:addWalkAnim]];
//        self.multAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:multWalkAnim]];
//        [_spriteAdd runAction:_addAction];
//        [_spriteMult runAction:_multAction];
//        
//        [beeAdd addChild:_spriteAdd];
//        [beeMult addChild:_spriteMult];
    }
    return self;
}

- (void)update:(ccTime)dt
{
//    CGPoint sprPos = ccp(25, 0);
    
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    for (UITouch *touch in touches)
    //    {
    //        CGPoint location = [touch locationInView:[touch view]];
    //        location = [[CCDirector sharedDirector]convertToGL:location];
    //        CGPoint point = [[CCDirector sharedDirector] convertToGL: location];
    //    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    for (UITouch *touch in touches)
    //    {
    //        //得到触摸屏上的点
    //        CGPoint location = [touch locationInView:[touch view]];
    //        location = [[CCDirector sharedDirector] convertToGL:location];
    //        //定义一个点，并把location赋值给point，为了在下面的代码执行中，不改变locaion的值
    //        CGPoint point = [[CCDirector sharedDirector] convertToGL: location];
    //    }
    
    //这里将jumpArray 改为了sharejumpArray
}

int i = 0,j = 0;
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     CGSize size = [[CCDirector sharedDirector]winSize];
	for( UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector]convertToGL:location];
        CCSprite *spriteadd = [allArray objectAtIndex:0];
         CGPoint point = [[CCDirector sharedDirector] convertToGL: location];
        
        for (CCSprite *sprite in allArray)
        {
            CGRect rect = [sprite textureRect];
            rect = CGRectMake(-rect.size.width/2, -rect.size.height/2, rect.size.width, rect.size.height);
            point = [sprite convertTouchToNodeSpaceAR:touch];
            if (CGRectContainsPoint(rect, point))
            {
                i++;
                [sprite stopAllActions];
                [sprite runAction:[CCFadeTo actionWithDuration:1.0f opacity:100]];
            }
            else
            {
                
            }
        }
    
        CCSprite *spritemutil = [allArray objectAtIndex:1];
        CGRect rect = [spriteadd textureRect];
        CGRect rect1 = [spritemutil textureRect];
        rect = CGRectMake(-rect.size.width/2, -rect.size.height/2, rect.size.width, rect.size.height);
        rect1 = CGRectMake(-rect1.size.width/2, -rect1.size.height/2, rect1.size.width, rect1.size.height);
        CGPoint point1 = [spritemutil convertTouchToNodeSpaceAR:touch];
        if (CGRectContainsPoint(rect, point))
        {
            NSLog(@"点击了加法精灵");
             spritemutil.flipX = YES;    //翻转精灵
            [self move:spritemutil :3 :CGPointMake(1300, size.height/2) :1];
             [self move:spriteadd :3 :CGPointMake(550,size.height/2) :1];
        }
        if (CGRectContainsPoint(rect1, point1))
        {
            NSLog(@"点击了乘法精灵");
            spriteadd.flipX = YES;
            [self move:spriteadd :5:CGPointMake(-40, size.height/2) :1];
            [self move:spritemutil :5 :CGPointMake(100, size.height/2) :1];
    //        spritemutil.flipX = YES;
        }
        
        
        for (int tag = 0; tag<=1; tag ++)               //这里暂时改为1  原来为7
        {
            CCSprite *sp = [allArray objectAtIndex:tag];  //这里应该为quanbu
            CGRect rect = [sp textureRect];
            rect = CGRectMake(-rect.size.width/2, -rect.size.height/2, rect.size.width, rect.size.height);
            CGPoint point = [sp convertTouchToNodeSpaceAR:touch];
            if (CGRectContainsPoint(rect, point))
            {
                if (tag == 0)
                {
                    [share.jumpArray insertObject:sp atIndex:0];
                    //_bear.flipX = NO;   翻转动画
                    
                }
                
                if (tag<2)
                {
                    if ([share.jumpArray count]== 0)
                    {
                        [share.jumpArray insertObject:sp atIndex:0];
                        [self move: sp:2:location:2];
                        break;
                    }
                    CCSprite *spp = [share.jumpArray objectAtIndex:0];
                    if (spp.tag != sp.tag)
                    {
                        [share.jumpArray removeObject:spp];
                        [share.jumpArray insertObject:sp atIndex:0];
                    }
                }
                else if (tag>=2&&tag<=6)
                {
                    if ([share.jumpArray count]==1)
                    {
                        [share.jumpArray insertObject:sp atIndex:1];
                        [self move: sp:2:location:2];
                        break;
                    }
                    CCSprite *spp = [share.jumpArray objectAtIndex:1];
                    [self move: sp:2:location:2];
                    if (spp.tag!=sp.tag)
                    {
                        [share.jumpArray removeObject:spp];
                        [share.jumpArray insertObject:sp atIndex:1];
                    }
             
                }
                else if (tag == 7)
                {
                    id action = [CCJumpTo actionWithDuration:2 position:location height:100 jumps:1];
                    [Icon runAction:action];
                    // http://blog.csdn.net/xiang08/article/details/8270150 讲的挺详细的
                    [self scheduleOnce:@selector(starButtonTapped) delay:3];
                    break;
                }
                [self move: sp:2:location:2];
                NSLog(@"jumpArray = %@",share.jumpArray);
            }
        }
    }
}

-(void)move:(CCSprite *)sprite:(ccTime)dur:(CGPoint)pos:(ccTime)delay         //移到一个位置
{
    id action0 = [CCMoveTo actionWithDuration:dur position:pos];
    id action1 = [CCFadeTo actionWithDuration:delay opacity:0];
    id action = [CCSequence actions:action0,action1,nil];
    [sprite runAction:action];
}

- (void)starButtonTapped
{
  // UINavigationController *navgationController;
  //  [navgationController pushViewController:[CCDirector sharedDirector] animated:YES];
  //  [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInL transitionWithDuration:1.2f scene:[initGameScene scene]]];//从左面
  //  [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInB transitionWithDuration:1.2f scene:[initGameScene scene]]];  //从上面
    [[CCDirector sharedDirector]replaceScene:[CCTransitionPageTurn transitionWithDuration:1.2f scene:[initGameScene scene]]];  //翻页
}

- (void) dealloc
{
    CCLOG(@"%@,%@",NSStringFromSelector(_cmd),self);
    [self removeFromParentAndCleanup:YES];
    [super dealloc];
}

@end
