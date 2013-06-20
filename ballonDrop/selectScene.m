//
//  selectScene.m
//  ballonDrop
//
//  Created by yaduan on 13-3-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.


//http://www.xuanyusong.com/archives/1878  参考地点



#import "selectScene.h"
#import "initGameScene.h"

#define velocity 10

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
        share.jumpArray = [[CCArray alloc]initWithCapacity:3];
        self.isTouchEnabled = YES;
        
        clickCount = 0;
        
        CGSize winsize = [[CCDirector sharedDirector]winSize];
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        [background setPosition:ccp(winsize.width/2, winsize.height/2)];
        background.anchorPoint = ccp(0.5, 0.5);
        [self addChild:background z:-1];
        [self initAnimationSprite];
    }
    return self;
}

-(void)initAnimationSprite
{
    allArray = [[CCArray alloc]initWithCapacity:5];
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
    
    _spriteAdd.position = ccp(20,510);
    _spriteMult.position = ccp(20, 310);
    _spriteTen.position = ccp(-250, 650);
    _spriteTwenty.position = ccp(-350, 560);
    _spriteThirty.position = ccp(-400,170);
    _spriteFifty.position = ccp(-250,280);
    _spriteHundred.position = ccp(-350,420);
    _spriteReset.position = ccp(1024+[_spriteReset textureRect].size.width/2,620);
    _spriteOK.position = ccp(1024+[_spriteOK textureRect].size.width/2, 450);
    
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
    
    id actionMove = [CCMoveTo actionWithDuration:4 position:CGPointMake(500, 510)];   //这里原先为5
    [_spriteAdd runAction:[CCSequence actions:actionMove, nil]];
    id actionMove1 = [CCMoveTo actionWithDuration:4 position:CGPointMake(500, 310)];
    [_spriteMult runAction:[CCSequence actions:actionMove1, nil]];
    
    [beeAdd addChild:_spriteAdd];
    [beeMult addChild:_spriteMult];
    [beeTen addChild:_spriteTen];
    [beeTwenty addChild:_spriteTwenty];
    [beeThirty addChild:_spriteThirty];
    [beeFifty addChild:_spriteFifty];
    [beeHundred addChild:_spriteHundred];
    [beeReset addChild:_spriteReset];
    [beeOK addChild:_spriteOK];
    
    [allArray addObject:_spriteAdd];
    [allArray addObject:_spriteMult];
    [allArray addObject:_spriteTen];
    [allArray addObject:_spriteTwenty];
    [allArray addObject:_spriteThirty];
    [allArray addObject:_spriteFifty];
    [allArray addObject:_spriteHundred];
    [allArray addObject:_spriteReset];
    [allArray addObject:_spriteOK];

}

- (void)update:(ccTime)dt{
    
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGSize winsize = [CCDirector sharedDirector].winSize;
    for( UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector]convertToGL:location];
        CGPoint point = [[CCDirector sharedDirector] convertToGL: location];
        if (clickCount == 0)
        {
            for (int k = 0 ; k <2 ; k++)
            {
                 CCSprite *sprite = [allArray objectAtIndex:k];
                 CGRect rect = [sprite textureRect];
                 rect = CGRectMake(-rect.size.width/2, -rect.size.height/2, rect.size.width, rect.size.height);
                 point = [sprite convertTouchToNodeSpaceAR:touch];
                 if (CGRectContainsPoint(rect, point))
                 {
                        clickCount++;
                        CCSprite *sp = [allArray objectAtIndex:1];
                        [sp runAction:[CCMoveTo actionWithDuration:5 position:CGPointMake(900,-100)]];  //这里原先为10
                        [self stopActionByTag:1];
                        CCSprite *sp1 = [allArray objectAtIndex:0];
                        [sp1 runAction:[CCMoveTo actionWithDuration:5 position:CGPointMake(900,900)]];
                        [self stopActionByTag:0];
                        [share.jumpArray addObject:sprite];
             
                        [_spriteTen runAction:[CCMoveTo actionWithDuration:6 position:CGPointMake(640, 650)]];    //这里原先为13
                        [_spriteTwenty runAction:[CCMoveTo actionWithDuration:6 position:CGPointMake(220, 560)]];
                        [_spriteThirty runAction:[CCMoveTo actionWithDuration:6 position:CGPointMake(640, 170)]];
                        [_spriteFifty runAction:[CCMoveTo actionWithDuration:6 position:CGPointMake(250, 280)]];
                        [_spriteHundred runAction:[CCMoveTo actionWithDuration:6 position:CGPointMake(570, 420)]];
                  }
            }
        }
        else if (clickCount == 1)
        {
            for (int k = 2 ; k < 7 ; k++)
            {
                CCSprite *sp = [allArray objectAtIndex:k];
                CGRect rect = [sp textureRect];
                rect = CGRectMake(-rect.size.width/2, -rect.size.height/2, rect.size.width, rect.size.height);
                point = [sp convertTouchToNodeSpaceAR:touch];
                if (CGRectContainsPoint(rect, point))
                {
                    clickCount++;

                    for (int k = 2 ; k < 7 ; k++)
                    {
                        CCSprite *sp1 = [allArray objectAtIndex:k];
                        [sp1 runAction:[CCMoveTo actionWithDuration:3 position:CGPointMake(arc4random()%1000, arc4random()%768)]];
                        [sp1 runAction:[CCFadeTo actionWithDuration:0.5 opacity:0]];
                    }
                    
                    [share.jumpArray addObject:sp];
                    [[share.jumpArray objectAtIndex:0] setPosition:CGPointMake(-150,winsize.height/2+[sp textureRect].size.height/2+30)];
                    [[share.jumpArray objectAtIndex:0]runAction:[CCMoveTo actionWithDuration:4 position:CGPointMake(winsize.width/2-100, winsize.height/2+[sp textureRect].size.height/2+30)]];
                    [[share.jumpArray objectAtIndex:1] setPosition:CGPointMake(-150,winsize.height/2-[sp textureRect].size.height/2-30)];
                    [[share.jumpArray objectAtIndex:1] runAction:[CCFadeTo actionWithDuration:0.5 opacity:255]];
                    [[share.jumpArray objectAtIndex:1]runAction:[CCMoveTo actionWithDuration:4 position:CGPointMake(winsize.width/2-100, winsize.height/2-[sp textureRect].size.height/2-30)]];
                    id actionMove2= [CCMoveTo actionWithDuration:4 position:CGPointMake(750, 620)];
                    [_spriteReset runAction:actionMove2];
                    id actionMove3 = [CCMoveTo actionWithDuration:4 position:CGPointMake(750, 450)];
                    [_spriteOK runAction:actionMove3];
                }
            }
        }
        
        else if(clickCount == 2)
        {
            for (int k = 7; k<9 ; k++)
            {
                CCSprite *sprite = [allArray objectAtIndex:k];
                CGRect rect = [sprite textureRect];
                rect = CGRectMake(-rect.size.width/2, -rect.size.height/2, rect.size.width, rect.size.height);
                point = [sprite convertTouchToNodeSpaceAR:touch];
                if (CGRectContainsPoint(rect, point))
                {
                    if(sprite.tag == 7)
                    {
                        [_spriteOK runAction:[CCFadeTo actionWithDuration:1 opacity:0]];
                        [_spriteReset runAction:[CCFadeTo actionWithDuration:1 opacity:0]];
                        [[share.jumpArray objectAtIndex:0]runAction:[CCFadeTo actionWithDuration:1 opacity:0]];
                        [[share.jumpArray objectAtIndex:1] runAction:[CCFadeTo actionWithDuration:1 opacity:0]];
                        [share.jumpArray removeAllObjects];
                        [[CCSpriteFrameCache sharedSpriteFrameCache]removeSpriteFramesFromFile:@"bee.plist"];
                        [allArray removeAllObjects];
                        clickCount = 0;
                        [self initAnimationSprite];
                    }
                    else if (sprite.tag == 8)
                    {
                        [self unscheduleUpdate];
                        [[CCDirector sharedDirector]replaceScene:[CCTransitionPageTurn transitionWithDuration:3.0f scene:[initGameScene scene]]];
                        break;
                    }
                } 
            }
        }
    }
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
