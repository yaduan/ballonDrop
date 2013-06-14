//
//  Shared.m
//  ballonDrop
//
//  Created by yaduan on 13-3-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Shared.h"


@implementation Shared

@synthesize FLAG;
@synthesize doRightNum;
@synthesize totalQuesNum;
@synthesize theOperationTypeTAG;
@synthesize allOpeSpriteArray;
@synthesize operatorArray;
@synthesize rangeResultNum;
@synthesize recordDataArray;
@synthesize dateArray;
@synthesize jumpArray;
@synthesize resultAndOperateArray;
@synthesize theTotalTimeOnEachQuestion;

static Shared *shared = nil;

+(Shared *)shared
{
    DebugMethod();
    if (shared == nil)
    {
        shared = [[Shared alloc]init];
    }
    return shared;
}

@end
