//
//  makeNewSprite.m
//  ballonDrop
//
//  Created by yaduan on 13-6-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "makeNewSprite.h"


@implementation makeNewSprite

-(id)init
{
    if(self = [super init]){
        
    }
    return self;
}

//制作精灵
+(id)callmakeSprite:(NSString *)sprite:(NSString *)numString:(NSString *)fontName:(NSInteger)size:(ccColor3B)color:(CGRect)rect:(CGPoint)position
{
    DebugMethod();
    CCSprite *opeSprite= [CCSprite spriteWithFile:sprite];
    CCLabelTTF* label = [CCLabelTTF labelWithString:numString fontName:fontName fontSize:size];
    CCSprite *sprt = [CCSprite spriteWithTexture:label.texture rect:rect];
    sprt.position = position;
    sprt.color = color;
    sprt.anchorPoint = CGPointMake(0.5,0.5);
    [opeSprite addChild:sprt];
    return opeSprite;
}

@end
