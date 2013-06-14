//
//  Shared.h
//  ballonDrop
//
//  Created by yaduan on 13-3-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Shared : CCNode {
}
@property (assign,nonatomic) BOOL FLAG;
@property (assign,nonatomic) int doRightNum;
@property (assign,nonatomic) int totalQuesNum;
@property (assign,nonatomic) int rangeResultNum;
@property (assign,nonatomic) int theOperationTypeTAG;
@property (assign,nonatomic) int theTotalTimeOnEachQuestion;
@property (nonatomic,retain) NSMutableArray *dateArray;
@property (nonatomic,retain) NSArray *recordDataArray;
@property (nonatomic,retain) CCArray *allOpeSpriteArray;
@property (nonatomic,retain) CCArray *operatorArray;
@property (nonatomic,retain) CCArray *resultAndOperateArray;
@property (nonatomic,retain) CCArray *jumpArray;

+(Shared *)shared;

@end
