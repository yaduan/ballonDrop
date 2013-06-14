//
//  SpriteMenu.h
//  DiceGameBox2D
//
//  Created by 电脑 富力 on 12-12-25.
//  Copyright (c) 2012年 科技. All rights reserved.
//菜单精灵

#import "cocos2d.h"
#import "ResourceLoad.h"

@interface SpriteMenu : CCSprite<CCTargetedTouchDelegate>
{
    CCSprite *normalImage;//没有选择的图片
    CCSprite *selImage;   //选着的图片
    
    id target; //调用对象
    SEL endedFunAddr; //触摸结束调用的函数
    SEL beganFunAddr;//触摸开始调用的函数
    
    BOOL isTouchEffect;//触摸特效
    
    float zoom;//缩放
}

@property(nonatomic,readwrite,assign)  CCSprite *normalImage;//没有选择的图片
@property(nonatomic,readwrite,assign)  CCSprite *selImage;   //选着的图片
@property(readwrite)BOOL isTouchEffect;

+(id)menuWithSpriteMenu:(id)imagePath SelImage:(id)selPath target:(id)tag  beganFunc:(SEL)beganFunc  endedFunc:(SEL)endedFunc;

-(id)initWithSpriteMenu:(id)imagePath SelImage:(id)selPath target:(id)tag  beganFunc:(SEL)beganFunc endedFunc:(SEL)endedFunc;

-(void)showNormalImage;
-(void)ShowSelectImage;



-(void)showEffect:(NSString*)name;//显示特效

@end
