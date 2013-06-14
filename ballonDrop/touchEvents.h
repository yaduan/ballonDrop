//
//  touchEvents.h
//  ballonDrop
//
//  Created by yaduan on 13-3-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBlade.h"
#import "SimpleAudioEngine.h"
#import "Shared.h"
#import "cocos2d.h"

@interface touchEvents : CCLayer
{
                         
    CGPoint startPoint;  //触摸变量
    CGPoint endPoint;
    
                         
    CCArray *blades;     //刀光变量
    CCBlade *blade;
    CCParticleSystemQuad *bladeSparkle; //刀光周围星星粒子变量
    
    CCArray *ballonarray;     //运动气球数组
    CCArray *numArray;        //运算符数组
    CCArray *cutBallonArray;
    CCArray *regionArray;
    
    Shared *sharedArray;     //定义其他文件的对象
    
                          
    float timeCurrent;       //播放音乐变量
    float timePrevious;
    CDSoundSource *swoosh;
     float deltaRemainder;
}

@property(nonatomic,retain)CDSoundSource *swoosh;
@property(nonatomic,retain)CCArray *ballonarray;
@property(nonatomic,retain)CCArray *numArray;
@property(nonatomic,retain)CCArray *cutBallonArray;

@end
