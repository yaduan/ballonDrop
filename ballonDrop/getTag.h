//
//  getTag.h
//  ballonDrop
//
//  Created by yaduan on 13-4-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "getTagDelegate.h"

@interface getTag : CCNode{
}

+(int)getoperateTag;

@property (nonatomic,retain) CCNode <getTagDelegate> *delegate;

@end