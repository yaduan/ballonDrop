//
//  randomOperand.h
//  ballonDrop
//
//  Created by yaduan on 13-3-20.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface randomOperand : CCNode
{
    int resultNum;
    int randomOperandNum1;
    int randomOperandNum2;
    int subNum2;
    int addnum2;
}

-(CCArray *)initAddSubNum:(int)randomNum;
-(CCArray *)initMultDiveNum:(int)randomNum;
+ (id) getOperateType;

@end
