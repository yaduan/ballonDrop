//
//  initGameScene.h
//  ballonDrop
//
//  Created by yaduan on 13-3-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBlade.h"
#import "SimpleAudioEngine.h"
#import "touchEvents.h"
#import "randomOperand.h"
#import "makeNewSprite.h"

#define speed 100.0

@interface initGameScene : CCLayer
{
    double nextTossTime;
    CCArray *opeArray;
    Shared  *sharedArray;
    makeNewSprite *makeSprite;
    CCSprite *resultSprite;
    double timer;
    
    float currentShowRect;
    CCLabelTTF *timeLimit;
    int remainTime;
    
    CCLabelTTF *totalQue;
    CCLabelTTF *doright;
    
}
@property(nonatomic,retain)CCSprite *resultSprite;

-(id)init;
+(CCScene *)scene;
-(void)resetAllSprite;
-(void) update: (ccTime) dt;
-(void)initThreeOpeNumSprite;        //初始化操作数精灵
-(void)initAddSubMutilDevSprite;     //初始化加减乘除精灵
-(void)initResultSprite;             //初始化结果数精灵
-(void)initPauseStartSprite;         //初始化暂停开始精灵
-(void)pauseScene;                   //暂停屏幕
-(void)makeBallonPositionRandom:(id)sender;
+ (void)endButtonTapped;
@end
