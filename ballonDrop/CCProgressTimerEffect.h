//
//  CCProgressTimerEffect.h
//  DiceGameBox2D
//
//  Created by jasonsalex on 13-1-27.
//
//自定义进度条

#import "cocos2d.h"

@interface CCProgressTimerEffect : CCProgressTimer
{
    float maxValue;//最大值
    float curValue;//当前数值
    CCSprite *bgSprite;//背景图片
}

@property(readwrite) float maxValue;

+(id)progressTimerWithEffect:(float)max_value background:(id)bg frontground:(id)fg;
-(id)initWithProgressTimerEffect:(float)max_value background:(id)bg frontground:(id)fg;

@end
