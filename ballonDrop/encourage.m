//
//  encourage.m
//  ballonDrop
//
//  Created by yaduan on 13-4-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "encourage.h"
#import "Shared.h"

@implementation encourage

-(id)init
{
    if((self = [super init]))
    {
        startHintIndex = 0;
        shared = [Shared shared];
        CCSprite *good = [CCSprite spriteWithFile:@"good.png"];
        NSString *letsGo = [NSString stringWithFormat:@"Lets Go"];
        oneActionArray = [[CCArray alloc]initWithCapacity:2];  //这里必需用initWithCapacity:来表示  否则程序会崩溃
        [oneActionArray addObject:good];
        [oneActionArray addObject:letsGo];
        
        CCSprite *well = [CCSprite spriteWithFile:@"well.png"];
        NSString *cheer = [NSString stringWithFormat:@"keep on fighting"];
        NSString *Go = [NSString stringWithFormat:@"Go"];
        twoActionArray = [[CCArray alloc]initWithCapacity:3];
        [twoActionArray addObject:well];
        [twoActionArray addObject:cheer];
        [twoActionArray addObject:Go];
        
        self.isTouchEnabled = NO;
    }
    return self;
}
-(void) onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
    if (shared.doRightNum == 5)      //这里要先判断是否已经做对了五道题
    {
        if(oneActionArray)
        {
           [self showEncourage];
        }
    }
    else if(shared.doRightNum == 15)                         //这里要判断是否做对了十道题  向下推
    {
        if(twoActionArray)
        {
            [self showEncourage];
        }
    }
    else if (shared.doRightNum>=20 && shared.doRightNum%10 == 0)
    {
        [self showEncourage];
    }
}

-(void) onEnter
{
	[super onEnter];
}
-(void) onExit
{
	[super onExit];
}

#pragma mark custom method

-(id)showEncourage
{
    startHintIndex = 0;
    if (shared.doRightNum == 5)      //这里要先判断是否已经做对了五道题
    {
       [self encourage:oneActionArray];
    }
    else if(shared.doRightNum == 15)                         //这里要判断是否做对了十道题  向下推
    {
        [self encourage:twoActionArray];
    }
    else if (shared.doRightNum>=20 && shared.doRightNum%10 == 0)
    {
        [self encourage1];
    }
    return self;
}

-(void) encourage:(CCArray *)array
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    if(startHintIndex>=[array count])
    {
        [array release];
		array = nil;
        self.isTouchEnabled = YES;
    }
    else
    {
        CCAction *action = [CCSequence actions:
                            [CCSpawn actions:
                             [CCScaleTo actionWithDuration:0.8f scaleX:2.5f scaleY:2.5f],
                             [CCSequence actions:
                              [CCFadeTo actionWithDuration: 0.6f opacity:255],
                              [CCFadeTo actionWithDuration: 0.2f opacity:128],
                              nil],
                             nil],
                            [CCCallFuncN actionWithTarget:self  selector:@selector(startHintCallback:)],
                            nil
                            ];
        if(startHintIndex == 0)
        {
            CCSprite *sprite = [array objectAtIndex:startHintIndex];
            sprite.position = ccp(size.width/2, size.height/2);
            sprite.opacity = 170;
            [self addChild:sprite];
            [sprite runAction:action];
        }
        else
        {
            NSString *hintText = [array objectAtIndex:startHintIndex];
                
            CCLabelTTF *label = [CCLabelTTF labelWithString:hintText fontName:@"Marker Felt" fontSize:40];
            label.position = ccp(size.width/2, size.height/2);
            label.opacity = 170;
            [self addChild:label];
            [label runAction: action];
        }
        startHintIndex++;
    }
}

-(void) startHintCallback: (id) sender
{
    [self removeChild:sender cleanup:YES];
    if (shared.doRightNum == 5)      //这里要先判断是否已经做对了五道题
    {
        [self encourage:oneActionArray];
    }
    else if(shared.doRightNum == 15)                         //这里要判断是否做对了十道题  向下推
    {
        [self encourage:twoActionArray];
    }
}

-(void)encourage1
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"You are great!" fontName:@"Marker Felt" fontSize:40];
    label.position = ccp(size.width/2,size.height/2);
    label.opacity = 170;
    CCAction *action = [CCSequence actions:
                        [CCSpawn actions:
                         [CCScaleTo actionWithDuration:0.8 scaleX:2.5f scaleY:2.5f],
                         [CCSequence actions:
                          [CCFadeTo actionWithDuration:0.7f opacity:255],
                          [CCFadeTo actionWithDuration:0.2f opacity:128],
                          nil],
                         nil],
                        [CCCallFuncN actionWithTarget:self  selector:@selector(startHintCallback:)],
                        nil];
    [self addChild:label];
    [label runAction:action];
    self.isTouchEnabled = YES;
}

-(void) dealloc
{
	[super dealloc];
}

@end
