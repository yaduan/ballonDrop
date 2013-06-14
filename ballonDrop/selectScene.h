//
//  selectScene.h
//  ballonDrop
//
//  Created by yaduan on 13-3-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Shared.h"

@interface selectScene : CCLayer
{
    CCParallaxNode *_backgroundNode;
    CCSprite *spacedust1;
    CCSprite *spacedust2;
    CCSprite *planetsunrise;
    CCSprite *galaxy;
    CCSprite *spacialanomaly;
    CCSprite *spacialanomaly2;
    
    CCSprite * operatorSprite;
    CCSprite * operandsSprite;
    
    CCSprite *Icon;
    CCSprite *sprite;
    CCSprite *sprite1;
    CCSprite *sprite2;
    CCSprite *sprite3;
    CCSprite *sprite4;
    CCSprite *sprite5;
    CCSprite *sprite6;
    CCSprite *OkSprite;
    
    CCArray *allArray;
    CCArray *jumpArray;
    
    Shared *share;

}
+(CCScene *) scene;
-(id) init;
- (void)starButtonTapped;

@end
