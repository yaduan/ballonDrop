//
//  encourage.h
//  ballonDrop
//
//  Created by yaduan on 13-4-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Shared.h"

@interface encourage : CCLayer {
    int startHintIndex;
    NSArray				*startHintArray;
    CCArray *oneActionArray;
    CCArray *twoActionArray;
    Shared  *shared;
}



@end
