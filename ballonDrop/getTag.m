//
//  getTag.m
//  ballonDrop
//
//  Created by yaduan on 13-4-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "getTag.h"
#import "Shared.h"

@implementation getTag

@synthesize delegate;

+(int)getoperateTag
{
    Shared *share = [Shared shared];
    CCSprite *sprite = [share.jumpArray objectAtIndex:0];
    int tag;
    switch (sprite.tag)
    {
        case 0:
            tag = 0;
            break;
        case 1:
            tag = 1;
            break;
        default:
            break;
    }
    share.theOperationTypeTAG = tag;
    return share.theOperationTypeTAG;
}

@end
