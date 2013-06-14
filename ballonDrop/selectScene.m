//
//  selectScene.m
//  ballonDrop
//
//  Created by yaduan on 13-3-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.


//http://www.xuanyusong.com/archives/1878  参考地点

#import "selectScene.h"
#import "initGameScene.h"

@implementation selectScene

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    selectScene *layer = [selectScene node];
    [scene addChild: layer];
     return scene;
}
-(id) init
{
    if( (self=[super init]) )
    {
        share = [Shared shared];
        allArray = [[CCArray alloc]initWithCapacity:5];
        share.jumpArray = [[CCArray alloc]initWithCapacity:3];
        self.isTouchEnabled = YES;
        //CCRotateBy， CCRotateTo  为旋转
        Icon = [CCSprite spriteWithFile:@"qww.png"];
        Icon.position = CGPointMake(200, 200);
        [self addChild:Icon z:2];
        
        sprite = [CCSprite spriteWithFile:@"66.png"];  //这个地方要换成别的
        sprite = [initGameScene callmakeSprite:@"66.png" :@"+ -" :@"Arial" :30:ccc3(125,125,125) :CGRectMake(0,0,64,64) :CGPointMake(sprite.contentSize.width/2+18,sprite.contentSize.height/2-8)];
        sprite.tag = 0;
        sprite.position = ccp(400, 400);
        [self addChild:sprite];
        [allArray addObject:sprite];
        
        sprite1 = [CCSprite spriteWithFile:@"11.png"];
        sprite1 = [initGameScene callmakeSprite:@"11.png" :@"* /" :@"Arial" :30:ccc3(125,125,125) :CGRectMake(0,0,64,64) :CGPointMake(sprite1.contentSize.width/2+18,sprite1.contentSize.height/2-8)];
        sprite1.tag = 1;
        sprite1.position = ccp(400, 200);
        [self addChild:sprite1];
        [allArray addObject:sprite1];
        
        sprite2 = [CCSprite spriteWithFile:@"66.png"];  //这个地方要换成别的
        sprite2 = [initGameScene callmakeSprite:@"66.png" :@"10" :@"Arial" :30:ccc3(125,125,125) :CGRectMake(0,0,64,64) :CGPointMake(sprite2.contentSize.width/2+18,sprite2.contentSize.height/2-8)];
        sprite2.tag = 2;
        sprite2.position = ccp(550, 700);
        [self addChild:sprite2];
        [allArray addObject:sprite2];
        
        sprite3 = [CCSprite spriteWithFile:@"11.png"];
        sprite3 = [initGameScene callmakeSprite:@"11.png" :@"20" :@"Arial" :30:ccc3(125,125,125) :CGRectMake(0,0,64,64) :CGPointMake(sprite1.contentSize.width/2+18,sprite1.contentSize.height/2-8)];
        sprite3.tag = 3;
        sprite3.position = ccp(550, 550);
        [self addChild:sprite3];
        [allArray addObject:sprite3];
        
        sprite4 = [CCSprite spriteWithFile:@"66.png"];  //这个地方要换成别的
        sprite4 = [initGameScene callmakeSprite:@"66.png" :@"30" :@"Arial" :30:ccc3(125,125,125) :CGRectMake(0,0,64,64) :CGPointMake(sprite.contentSize.width/2+18,sprite.contentSize.height/2-8)];
        sprite4.tag = 4;
        sprite4.position = ccp(550, 400);
        [self addChild:sprite4];
        [allArray addObject:sprite4];
        
        sprite5 = [CCSprite spriteWithFile:@"11.png"];
        sprite5 = [CCSprite spriteWithFile:@"11.png"];
        sprite5 = [initGameScene callmakeSprite:@"11.png" :@"50" :@"Arial" :30:ccc3(125,125,125) :CGRectMake(0,0,64,64) :CGPointMake(sprite1.contentSize.width/2+18,sprite1.contentSize.height/2-8)];
        sprite5.tag = 5;
        sprite5.position = ccp(550, 250);
        [self addChild:sprite5];
        [allArray addObject:sprite5];
        
        sprite6 = [CCSprite spriteWithFile:@"66.png"];  //这个地方要换成别的
        sprite6 = [initGameScene callmakeSprite:@"66.png" :@"100" :@"Arial" :30:ccc3(125,125,125) :CGRectMake(0,0,64,64) :CGPointMake(sprite6.contentSize.width/2+18,sprite6.contentSize.height/2-8)];
        sprite6.tag = 6;
        sprite6.position = ccp(550, 100);
        [self addChild:sprite6];
        [allArray addObject:sprite6];
        
        OkSprite = [CCSprite spriteWithFile:@"66.png"];  //这个地方要换成别的
        OkSprite = [initGameScene callmakeSprite:@"66.png" :@"OK" :@"Arial" :30:ccc3(125,125,125) :CGRectMake(0,0,64,64) :CGPointMake(sprite.contentSize.width/2+18,sprite.contentSize.height/2-8)];
        OkSprite.tag = 7;
        OkSprite.position = ccp(700, 400);
        [self addChild:OkSprite];
        [allArray addObject:OkSprite];

        //新加 （1）
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        _backgroundNode = [CCParallaxNode node];
        [self addChild:_backgroundNode z:-1];
        
        // 2) Create the sprites we'll add to the CCParallaxNode
        spacedust1 = [CCSprite spriteWithFile:@"background1.png"];
        spacedust2 = [CCSprite spriteWithFile:@"background1.png"];
        planetsunrise = [CCSprite spriteWithFile:@"bg_planetsunrise.png"];
        galaxy = [CCSprite spriteWithFile:@"bg_galaxy.png"];
        spacialanomaly = [CCSprite spriteWithFile:@"bg_spacialanomaly.png"];
        spacialanomaly2 = [CCSprite spriteWithFile:@"bg_spacialanomaly2.png"];
        
        // 3) Determine relative movement speeds for space dust and background
        CGPoint dustSpeed = ccp(0.1, 0.1);
        CGPoint bgSpeed = ccp(0.05, 0.05);
        
        // 4) Add children to CCParallaxNode
        [_backgroundNode addChild:spacedust1 z:0 parallaxRatio:dustSpeed positionOffset:ccp(spacedust1.contentSize.width/2,spacedust1.contentSize.height/2)];
        [_backgroundNode addChild:spacedust2 z:0 parallaxRatio:dustSpeed positionOffset:ccp(spacedust1.contentSize.width/2,spacedust1.contentSize.height+spacedust2.contentSize.height/2)];
        [_backgroundNode addChild:galaxy z:1 parallaxRatio:bgSpeed positionOffset:ccp(winSize.width*0.8,winSize.height *0.7)];
        [_backgroundNode addChild:planetsunrise z:1 parallaxRatio:bgSpeed positionOffset:ccp(winSize.width*0.4,winSize.height)];
        [_backgroundNode addChild:spacialanomaly z:1 parallaxRatio:bgSpeed positionOffset:ccp(winSize.width*0.6,900)];
        [_backgroundNode addChild:spacialanomaly2 z:1 parallaxRatio:bgSpeed positionOffset:ccp(winSize.width *0.9,1500)];
    }
    return self;
}

- (void)update:(ccTime)dt {
    
    CGPoint backgroundScrollVel = ccp(-500, -1000);
    _backgroundNode.position = ccpAdd(_backgroundNode.position, ccpMult(backgroundScrollVel, dt));
    
    CGPoint sprPos = ccp(-25, -50);
    sprite1.position = ccpAdd(sprite1.position , ccpMult(sprPos, dt));
    Icon.position = ccpAdd(Icon.position , ccpMult(sprPos, dt));
    
}

-(void)starButton
{
    [self scheduleUpdate];
    [self scheduleOnce:@selector(stop) delay:2];
    
}

-(void)loadBG
{
    NSString *fileName = [NSString stringWithFormat:@"66.png"];
    NSString *fileName1 = [NSString stringWithFormat:@"well.png"];
    NSString *fileName2 = [NSString stringWithFormat:@"11.png"];
    NSString *fileName3 = [NSString stringWithFormat:@"101.png"];
    
    CCSpriteFrame* frame = [CCSpriteFrame frameWithTextureFilename:fileName rect:CGRectMake(0, 0, 128, 128)];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame:frame name:[fileName stringByDeletingPathExtension]];
    
    CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTextureFilename:fileName1 rect:CGRectMake(0, 0, 200, 90)];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame:frame1 name:[fileName1 stringByDeletingPathExtension]];
    
    CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTextureFilename:fileName2 rect:CGRectMake(0, 0, 180, 180)];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame:frame2 name:[fileName2 stringByDeletingPathExtension]];
    
    CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTextureFilename:fileName3 rect:CGRectMake(0, 0, 135, 135)];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame:frame3 name:[fileName3 stringByDeletingPathExtension]];
}

-(void)setAnimal
{
    
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    NSMutableArray *animFrames = [NSMutableArray array];
    [animFrames addObject:[frameCache spriteFrameByName:@"66.png"]];
    [animFrames addObject:[frameCache spriteFrameByName:@"well.png"]];
    [animFrames addObject:[frameCache spriteFrameByName:@"11.png"]];
    [animFrames addObject:[frameCache spriteFrameByName:@"101.png"]];
    
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animBG = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
    //生成动画播放的行为对象
    id actBG = [CCAnimate actionWithAnimation:animBG];
    //清空缓存数组
    [animFrames removeAllObjects];
    [sprite1 runAction:actBG];
    
}

-(void)stop
{
    [self unscheduleUpdate];
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

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector]convertToGL:location];
        
        for (int tag = 0; tag<=7; tag ++)
        {
            CCSprite *sp = [allArray objectAtIndex:tag];  //这里应该为quanbu
            CGRect rect = [sp textureRect];
            rect = CGRectMake(-rect.size.width/2, -rect.size.height/2, rect.size.width, rect.size.height);
            CGPoint point = [sp convertTouchToNodeSpaceAR:touch];
            if (CGRectContainsPoint(rect, point))
            {
                if (tag<2)
                {
                    if ([share.jumpArray count]== 0)
                    {
                        [share.jumpArray insertObject:sp atIndex:0];
                        [self jump:2:location:100:1:2];
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
                        [self jump:2:location:100:1:2];
                        break;
                    }
                    CCSprite *spp = [share.jumpArray objectAtIndex:1];
                    [self jump:2:location:100 :1:2];
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
                [self jump:2:location:100:1:2];
                NSLog(@"jumpArray = %@",share.jumpArray);
            }
        }
    }
}

-(void)jump:(ccTime)dur:(CGPoint)pos:(ccTime)hei:(NSUInteger)jumps:(ccTime)tim
{
    id action = [CCJumpTo actionWithDuration:dur position:pos height:hei jumps:jumps];
    [Icon runAction:action];
    [self scheduleOnce:@selector(starButton) delay:tim];
}

- (void)starButtonTapped
{
    NSLog(@"zhixing");
  // UINavigationController *navgationController;
  //  [navgationController pushViewController:[CCDirector sharedDirector] animated:YES];
  //  [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInL transitionWithDuration:1.2f scene:[initGameScene scene]]];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInB transitionWithDuration:1.2f scene:[initGameScene scene]]];
}

- (void) dealloc
{
    CCLOG(@"%@,%@",NSStringFromSelector(_cmd),self);
    //    [self removeFromParentAndCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    [super dealloc];
}

@end
