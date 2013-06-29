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
#import "Shared.h"

#define speed 110.0

@interface initGameScene : CCLayer 
{
    double nextTossTime;
    Shared  *sharedArray;
    makeNewSprite *makeSprite;
    CCSprite *resultSprite;
    
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
-(void)resultScene;
-(void)stopAllAction;
-(void)initScoreTitle;
-(void)initScore;
-(void)initTimeLimit;
-(void)GetRecord;
-(void)makeBallonPositionRandom:(id)sender;
-(BOOL) saveGameData:(NSString *)data  saveFileName:(NSString *)fileName;
-(void)getTimeLimit;
-(void)resetAllSprite;
-(void)createNextThreeOpeNumAddSubMutilDevSprite;
-(id) loadGameData:(NSString *)fileName;
-(void)getEncourage;
+ (void)endButtonTapped;

@end

