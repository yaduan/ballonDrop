//
//  linedraw.h
//  ballonDrop
//
//  Created by yaduan on 13-4-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface linedraw : CCSprite
{
    CGPoint startPoint;
    CGPoint endPoint;
}

@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint endPoint;
@end
