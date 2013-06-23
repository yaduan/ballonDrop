//
//  startScene.m
//  ballonDrop
//
//  Created by yaduan on 13-6-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "startScene.h"
#import "selectScene.h"


@implementation startScene

@synthesize backgroundNode = _backgroundNode;
@synthesize girlSprite = _girlSprite;
@synthesize boySprite = _boySprite;
@synthesize girlAction = _girlAction;
@synthesize boyAction = _boyAction;

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    startScene *layer = [startScene node];
    [scene addChild: layer];
    return scene;
}

-(id)init
{
    if(self = [super init])
    {
        //(1)调用CCSpriteFrameCache的addSpriteFramesWithFile方法，然后把Zwoptex生成的plist文件当作参数传进去
        //寻找工程目录下面和输入的参数名字一样，但是后缀是.png的图片文件。然后把这个文件加入到共享的CCTextureCache中。（这我们这个例子中，就是加载AnimBear.png）
        //解析plist文件，追踪所有的sprite在spritesheet中的位置，内部使用CCSpriteFrame对象来追踪这些信息。
        
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"girl.plist"];
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"boy.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"girlandboy.plist"];
        
        //2) 创建一个精灵批处理结点
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"girlandboy.png"];
        [self addChild:spriteSheet];
//        CCSpriteBatchNode *bspriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"boy.png"];
//        [self addChild:bspriteSheet];
        
        //(3)创建CCSpriteBatchNode对象，把spritesheet当作参数传进去。收集帧列表
        NSMutableArray *walkGirl = [NSMutableArray array];
        NSMutableArray *walkBoy = [NSMutableArray array];
        
        //为了创建一系列的动画帧，我们简单地遍历我们的图片名字（它们是按照XX1.png-->XX2.png的方式命名的），然后使用共享的CCSpriteFrameCache来获得每一个动画帧。记住，它们已经在缓存里了，因为我们前面调用了addSpriteFramesWithFile方法。
        for(int i = 1 ; i <= 2 ; i++ )
        {
            [walkGirl addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"girl%d.png",i]]];
            [walkBoy addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"boy%d.png",i]]];
        }
        
        //(4)创建动画对象
        CCAnimation *gwalkAnim = [CCAnimation animationWithSpriteFrames:walkGirl delay:0.3f];
        CCAnimation *bwalkAnim = [CCAnimation animationWithSpriteFrames:walkBoy delay:0.3f];
        self.girlSprite = [CCSprite spriteWithSpriteFrameName:@"girl1.png"];
        self.boySprite = [CCSprite spriteWithSpriteFrameName:@"boy1.png"];
        _girlSprite.position = ccp(760,430);
        _boySprite.position = ccp(300, 430);
        
        //(5)接下来，我们通过传入sprite帧列表来创建一个CCAnimation对象，并且指定动画播放的速度。我们使用０.１来指定每个动画帧之间的时间间隔。 创建sprite并且让它run动画action
        self.girlAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:gwalkAnim]];
        self.boyAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:bwalkAnim]];
        [_girlSprite runAction:_girlAction];
        [_boySprite runAction:_boyAction];
        
        [spriteSheet addChild:_girlSprite];
        [spriteSheet addChild:_boySprite];
        
        //新加 （1）
        _backgroundNode = [CCParallaxNode node];
        [self addChild:_backgroundNode z:-1];
        
        // 2) Create the sprites we'll add to the CCParallaxNode
        spacedust1 = [CCSprite spriteWithFile:@"nature1.png"];
        spacedust2 = [CCSprite spriteWithFile:@"nature2.png"];
        
        // 3) Determine relative movement speeds for space dust and background
        CGPoint dustSpeed = ccp(0.2, 0.2);
        
        // 4) Add children to CCParallaxNode
        [_backgroundNode addChild:spacedust1 z:0 parallaxRatio:dustSpeed positionOffset:ccp(spacedust1.contentSize.width/2,spacedust1.contentSize.height/2)];
        [_backgroundNode addChild:spacedust2 z:0 parallaxRatio:dustSpeed positionOffset:ccp(spacedust1.contentSize.width/2+spacedust2.contentSize.width-4,spacedust1.contentSize.height/2)];
        
        [self scheduleUpdate];
        [self scheduleOnce:@selector(enterNextScene) delay:5];
    }
    return self;
}

-(void)update:(ccTime)dt
{
    CGPoint backgroundScrollVel = ccp(-800, 0);
    _backgroundNode.position = ccpAdd(_backgroundNode.position, ccpMult(backgroundScrollVel, dt));
}

-(void)enterNextScene
{
       [self unscheduleUpdate];
       [[CCDirector sharedDirector]replaceScene:[CCTransitionPageTurn transitionWithDuration:3.0f scene:[selectScene scene]]];  //翻页
}

-(void)dealloc
{
    [super dealloc];
//    self.boySprite = nil;
//    self.girlSprite = nil;
}

@end
