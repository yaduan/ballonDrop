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
#import "aboutGame.h"

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
    
    CCAction *walkAction;
    CCAction *moveAction;
    BOOL moving;
    
    CCSprite *spriteAdd;
    CCSprite *spriteMult;
    CCSprite *spriteTen;
    CCSprite *spriteTwenty;
    CCSprite *spriteThirty;
    CCSprite *spriteFifty;
    CCSprite *spriteHundred;
    CCSprite *spriteReset;
    CCSprite *spriteOK;
    
    CCLabelTTF *labelabout;
    CCLabelTTF *labelone;
    CCLabelTTF *labeltwo;
    CCLabelTTF *labelthree;
    CCLabelTTF *labelfour;
    CCLabelTTF *labelfive;
    CCLabelTTF *labelsix;
    CCLabelTTF *labelseven;
    
    CCArray *allArray;
    CCArray *jumpArray;
    
    Shared *share;
    aboutGame *rec;
    
    NSInteger  clickCount;
    NSInteger  count;
    

}

@property (nonatomic,retain) CCSprite *Icon;
@property (nonatomic,retain) CCAction *walkAction;
@property (nonatomic,retain) CCAction *moveAction;

@property (nonatomic,retain) CCSprite *spriteAdd;
@property (nonatomic,retain) CCSprite *spriteMult;
@property (nonatomic,retain) CCSprite *spriteTen;
@property (nonatomic,retain) CCSprite *spriteTwenty;
@property (nonatomic,retain) CCSprite *spriteThirty;
@property (nonatomic,retain) CCSprite *spriteFifty;
@property (nonatomic,retain) CCSprite *spriteHundred;
@property (nonatomic,retain) CCSprite *spriteReset;
@property (nonatomic,retain) CCSprite *spriteOK;

@property (nonatomic,retain) CCAction *addAction;
@property (nonatomic,retain) CCAction *multAction;
@property (nonatomic,retain) CCAction *tenAction;
@property (nonatomic,retain) CCAction *twentyAction;
@property (nonatomic,retain) CCAction *thirtyAction;
@property (nonatomic,retain) CCAction *fiftyAction;
@property (nonatomic,retain) CCAction *hundredAction;
@property (nonatomic,retain) CCAction *resetAction;
@property (nonatomic,retain) CCAction *okAction;

+(CCScene *) scene;
-(id) init;
- (void)starButtonTapped;

@end
