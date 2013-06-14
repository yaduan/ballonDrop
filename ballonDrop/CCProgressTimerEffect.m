//
//  CCProgressTimerEffect.m
//  DiceGameBox2D
//
//  Created by jasonsalex on 13-1-27.
//
//

#import "CCProgressTimerEffect.h"

@implementation CCProgressTimerEffect

@synthesize maxValue;

+(id)progressTimerWithEffect:(float)max_value background:(id)bg frontground:(id)fg
{
    return [[[self alloc]initWithProgressTimerEffect:max_value background:bg frontground:fg]autorelease];
}

-(id)initWithProgressTimerEffect:(float)max_value background:(id)bg frontground:(id)fg
{
    if(self=[super initWithFile:fg]);
    {
        maxValue=max_value;
        bgSprite=[CCSprite spriteWithFile:bg rect:[self boundingBox]];
        
        CGSize size=[self boundingBox].size;
        
        size.width = size.width - 100;
        size.height=size.height + 100;

        [bgSprite setPosition:ccp(size.width,size.height)];
        
        [self addChild:bgSprite z:0];
        
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"~ProgressTimer");
    [super dealloc];
}

//是个委托方法
-(void)setPercentage:(float)percentage
{
    curValue=percentage;
    [super setPercentage:curValue/maxValue*100.0f];
}


@end
