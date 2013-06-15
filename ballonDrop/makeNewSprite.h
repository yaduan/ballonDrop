//
//  makeNewSprite.h
//  ballonDrop
//
//  Created by yaduan on 13-6-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface makeNewSprite : CCLayer{
    
}

-(CCSprite *)makeSprite:(NSString *)sprite:(NSString *)numString:(NSString *)fontName:(NSInteger)size:(ccColor3B)color:(CGRect)rect:(CGPoint)position;
+(id)callmakeSprite:(NSString *)sprite:(NSString *)numString:(NSString *)fontName:(NSInteger)size:(ccColor3B)color:(CGRect)rect:(CGPoint)position;

@end
