//
//  restartGame.m
//  ballonDrop
//
//  Created by yaduan on 13-3-26.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.


// http://blog.sina.com.cn/s/blog_7608655901012qac.html  参考网址

#import "restartGame.h"
#import "initGameScene.h"

@implementation restartGame

@synthesize delegete;


+(id)gamePause:(id)_delegate
{
    return [[self alloc]initPause:_delegate];
}

-(id)initWithStart:(id)_delegate
{
    if(self = [super init])
    {
        delegate = _delegate;
        [self pauseDelegate];
    }
    return self;
}

-(id)initPause:(id)_delegate
{
    if(self = [super init])
    {
        delegate = _delegate;
        [self pauseDelegate];
    }
    return self;
}

-(void)pauseDelegate
{
    //    if([delegate respondsToSelector:@selector(pauseLayerDidPause)])
    //        [delegate pauseLayerDidPause];
    [delegate onExit];
    [delegate.parent addChild:self z:10];   //这里在当前的场景上加载其他的场景
}

-(void)doResume: (id)sender
{
    [delegate onEnter];
    //if([delegate respondsToSelector:@selector(pauseLayerDidUnpause)])
    //[delegate pauseLayerDidUnpause];
    [self.parent removeChild:self cleanup:YES];
}

-(void)onEnter   //转换到新场景时调用该方法  addTargetedDelegate:priority:swallowsTouches:针对实现目标协议的代理对象的触摸注册方法
                 //delegate–触摸对象 priority–触摸消息分发的优先级，注意：此值越小，优先级越高
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:10 swallowsTouches:YES];
    [super onEnter];
}

-(void)onExit   //转场结束时旧场景才能退出
{
    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
    [super onExit];
}

-(void)dealloc
{
    [super dealloc];
}

/*- (id) initWithColor:(ccColor4B)c delegate:(id)_delegate
 {
 self = [super initWithColor:c];
 if (self != nil) {
 CGSize wins = [[CCDirector sharedDirector] winSize];
 delegate = _delegate;
 [self pauseDelegate];
 CCSprite * background = [CCSprite spriteWithFile:@"balloon.png"];
 [self addChild:background];
 CCMenuItemImage *resume = [CCMenuItemImage itemWithNormalImage:@"balloon.png"
 selectedImage:@"balloon1.png"
 target:self
 selector:@selector(doResume:)];
 CCMenu * menu = [CCMenu menuWithItems:resume,nil];
 [menu setPosition:ccp(0,0)];
 [resume setPosition:ccp([background boundingBox].size.width/2,[background boundingBox].size.height/2)];
 [background addChild:menu];
 [background setPosition:ccp(wins.width/2,wins.height/2)];
 }
 return self;
 }*/


@end
