//
//  operatorType.m
//  ballonDrop
//
//  Created by yaduan on 13-4-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "operatorType.h"
#import "Shared.h"
#import "getTag.h"

@implementation operatorType

+(CCArray *)getOperatorType
{
    int tag = [getTag getoperateTag];    //这里的tag表示   这里来传入按钮的tag
    Shared *share = [Shared shared];
    share.operatorArray = [CCArray arrayWithCapacity:2];
    if(tag == 0)
    {
        [share.operatorArray addObject:@"+"];
        [share.operatorArray addObject:@"-"];
    }
    if(tag == 1)
    {
        [share.operatorArray addObject:@"*"];
        [share.operatorArray addObject:@"/"];
    }
    return share.operatorArray;
}

@end
