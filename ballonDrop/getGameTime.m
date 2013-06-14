//
//  getGameTime.m
//  ballonDrop
//
//  Created by yaduan on 13-3-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "getGameTime.h"
#import "Shared.h"


@implementation getGameTime

+(int)getTheSetTime
{
    int time = 15;
    Shared *shared = [Shared shared];
    shared.theTotalTimeOnEachQuestion = time;
    return shared.theTotalTimeOnEachQuestion;
}

@end
