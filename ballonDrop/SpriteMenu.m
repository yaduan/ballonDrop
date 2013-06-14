//
//  SpriteMenu.m
//  DiceGameBox2D
//
//  Created by 电脑 富力 on 12-12-25.
//  Copyright (c) 2012年 科技. All rights reserved.
//

#import "SpriteMenu.h"

@implementation SpriteMenu

@synthesize normalImage;
@synthesize selImage;
@synthesize isTouchEffect;

+(id)menuWithSpriteMenu:(id)imagePath SelImage:(id)selPath target:(id)tag  beganFunc:(SEL)beganFunc  endedFunc:(SEL)endedFunc;
{
    return [[[self alloc] initWithSpriteMenu:imagePath SelImage:selPath target:tag beganFunc:beganFunc endedFunc:endedFunc]autorelease];
}

-(id)initWithSpriteMenu:(id)imagePath SelImage:(id)selPath target:(id)tag  beganFunc:(SEL)beganFunc endedFunc:(SEL)endedFunc;
{
    if(self=[super init])
    {
                
        normalImage=[[CCSprite alloc]initWithFile:imagePath];
        selImage=[[CCSprite alloc]initWithFile:selPath];
        
        target=tag;
        endedFunAddr=endedFunc;
        beganFunAddr=beganFunc;
        
        [self setDisplayFrame:[normalImage displayedFrame]];
        isTouchEffect=FALSE;//默认启用触摸特效的
        zoom=[self scale];
    }
    
    return self;
}

-(void)dealloc
{
    NSLog(@"~SpriteMenu");
    [normalImage release];
    [selImage release];
    
    [super dealloc];
}


-(void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:10 swallowsTouches:YES];
    
    [super onEnter];
}

-(void)onExit
{
    [[CCTouchDispatcher sharedDispatcher]removeDelegate:self];

    [super onExit];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocal=[touch locationInView:[touch view]];
    touchLocal=[[CCDirector sharedDirector]convertToGL:touchLocal];
    
    BOOL isTouch=CGRectContainsPoint([self boundingBox], touchLocal);
    if(isTouch)
    {
        [self ShowSelectImage];
            
            if(isTouchEffect) //是否使用了触摸特效
            {
                id scaleTo=[CCScaleTo actionWithDuration:0.25f scale:zoom-0.2f];
                id callfunc=nil;
                
                if(beganFunAddr!=nil)
                    callfunc=[CCCallFunc actionWithTarget:target selector:beganFunAddr];
                
                id sequece=[CCSequence actions:scaleTo, callfunc,nil];
                [self runAction:sequece];
            
            }else
            {
                if(beganFunAddr!=nil)
                    [target performSelector:beganFunAddr];
            }

    }
    
    return isTouch;
}


-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{

}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self showNormalImage];
    
    if(isTouchEffect)
    {
        id scaleTo=[CCScaleTo actionWithDuration:0.25f scale:zoom+0.2f];
        id scaleTo1=[CCScaleTo actionWithDuration:0.25f scale:zoom];
        
        id callfunc=nil;
        
        if(endedFunAddr!=nil)
            callfunc=[CCCallFunc actionWithTarget:target selector:endedFunAddr];
        
        CCSequence* sequece=[CCSequence actions:scaleTo,scaleTo1,callfunc,nil];
        
        [self runAction:sequece];
    }else
    {
        if(endedFunAddr!=nil)
            [target performSelector:endedFunAddr];
    }

}


-(void)showNormalImage
{
    [self setDisplayFrame:[normalImage displayedFrame]];
}

-(void)ShowSelectImage
{
    [self setDisplayFrame:[selImage displayedFrame]];
}

-(void)showEffect:(NSString*)name//显示特效
{
    if([name isEqualToString:@"stretch"])//拉伸特效
    {
        [self setScaleX:0];
        id scaleXTo=[CCScaleTo actionWithDuration:2.0f scale:zoom];//拉伸
        id fadeIn=[CCFadeIn actionWithDuration:2.0f];
        
        id spawn=[CCSpawn actions:scaleXTo,fadeIn,nil];
        
        [self runAction:spawn];
    }
}

@end
