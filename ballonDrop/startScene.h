//
//  startScene.h
//  ballonDrop
//
//  Created by yaduan on 13-6-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface startScene : CCLayer
{
    CCParallaxNode *backgroundNode;
    CCSprite *spacedust1;
    CCSprite *spacedust2;
    
    CCSprite *girlSprite;
    CCSprite *boySprite;
    
    CCAction *girlAction;
    CCAction *boyAction;
}

@property (nonatomic,retain) CCParallaxNode *backgroundNode;

@property (nonatomic,retain) CCSprite *girlSprite;
@property (nonatomic,retain) CCSprite *boySprite;

@property (nonatomic,retain) CCAction *girlAction;
@property (nonatomic,retain) CCAction *boyAction;

+(CCScene *) scene;

@end
