//
//  getResultRange.m
//  ballonDrop
//
//  Created by yaduan on 13-4-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "getResultRange.h"
#import "Shared.h"


@implementation getResultRange

+(int)getResultNum
{
    Shared *shared = [Shared shared];
    int resultNum;
    CCSprite *sprite = [shared.jumpArray objectAtIndex:1];
    switch (sprite.tag)
    {
        case 2:
            resultNum = 10;
            break;
        case 3:
            resultNum = 20;
            break;
        case 4:
            resultNum = 30;
            break;
        case 5:
            resultNum = 50;
            break;
        case 6:
            resultNum = 100;
            break;
        default:
            break;
    }
    shared.rangeResultNum = resultNum;
    return shared.rangeResultNum;
}

@end
