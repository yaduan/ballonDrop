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
#import "Box2D.h"

#define speed 100.0

@interface initGameScene : CCLayer
{
    double nextTossTime;
    CCArray *opeArray;
    Shared  *sharedArray;
    CCSprite *resultSprite;
    double timer;
    
    float currentShowRect;
    CCLabelTTF *timeLimit;
    int remainTime;
    
    CCLabelTTF *totalQue;
    CCLabelTTF *doright;
    
    //定义一个世界b2world
    b2World *world;
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
-(CCSprite *)makeSprite:(NSString *)sprite:(NSString *)numString:(NSString *)fontName:(NSInteger)size:(ccColor3B)color:(CGRect)rect:(CGPoint)position;
+(id)callmakeSprite:(NSString *)sprite:(NSString *)numString:(NSString *)fontName:(NSInteger)size:(ccColor3B)color:(CGRect)rect:(CGPoint)position;

@end
