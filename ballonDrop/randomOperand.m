//
//  randomOperand.m
//  ballonDrop
//
//  Created by yaduan on 13-3-20.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "randomOperand.h"
#import "Shared.h"
#import "getResultRange.h"
#import "getTag.h"

@implementation randomOperand

+ (id) getOperateType
{
    DebugMethod();
    switch ([getTag getoperateTag])
    {
        case 0:
            [[self alloc]initAddSubNum:[getResultRange getResultNum]];
            break;
        case 1:
            [[self alloc]initMultDiveNum:[getResultRange getResultNum]];   //这个地方以后要换成其他的场景
            break;
        default:
            break;
    }
    return self;
}

-(CCArray *)initAddSubNum:(int)randomNum
{
    Shared *sharedArray = [Shared shared];
    sharedArray.resultAndOperateArray = [CCArray arrayWithCapacity:4];
    while (1)
    {
        resultNum = arc4random()%randomNum;
        if(resultNum > 1)
        {
            [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:resultNum]];
            break;
        }
    }
    while (1)
    {
        randomOperandNum1 = arc4random()%randomNum;
        if(randomOperandNum1!=resultNum && randomOperandNum1>0)
        {
            [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum1]];
            break;
        }
    }
    subNum2 = randomOperandNum1-resultNum;
    addnum2 = randomOperandNum1+resultNum;
    if(addnum2<randomNum||addnum2==randomNum)
    {
        [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:addnum2]];
    }
    else if(addnum2>randomNum)
    {
        if(subNum2>0)[sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:subNum2]];
        if(subNum2<0)
        {
            subNum2 = 0-subNum2;
            [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:subNum2]];
        }
    }
    while (1)
    {
        int otherNum = arc4random()%randomNum;
        if(otherNum!=randomOperandNum1&&otherNum!=subNum2&&otherNum!=addnum2&&otherNum!=resultNum&&otherNum>0)
        {
            [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:otherNum]];
            break;
        }
    }
    return sharedArray.resultAndOperateArray;
}

-(CCArray *)initMultDiveNum:(int)randomNum
{
    int tag = 0;
    Shared *sharedArray = [Shared shared];
    sharedArray.resultAndOperateArray = [CCArray arrayWithCapacity:4];
    
    //随即生成结果数
    while(1)
    {
        resultNum = arc4random()%randomNum;
        if(resultNum > 1)
        {
            //判断生成的结果数是否为素数
            for(int i=2;i<resultNum;i++)
            {
                if(resultNum%i ==0)  { tag = 1 ;}
            }
            if(tag == 1)
            {
                [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:resultNum]];
                break;
            }
        }
    }
    while (1)
    {
        int num2;
        randomOperandNum1 = arc4random()%randomNum;
        if(randomOperandNum1>resultNum)
        {
            num2 = randomOperandNum1%resultNum;  //当生成的第一个数大于结果数
                                                 //让第一个数除以结果数，如果能整除就加到数组中
                                                 //如果不能整除就相乘
            if(num2 == 0)
            {
                randomOperandNum2 = randomOperandNum1/resultNum;
                [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum1]];
                [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum2]];
                break;
            }
            else
            {
                num2 = randomOperandNum1*resultNum; 
                if(num2<randomNum||num2==randomNum)
                {
                    randomOperandNum2 = num2;
                    [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum1]];
                    [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum2]];
                    break;
                }
            }
        }
        else if(randomOperandNum1<resultNum&&randomOperandNum1>1)//当生成的第一个数小于结果数
                                                                 //让结果数除以第一个数，如果能整除就加到数组中
                                                                 //如果不能整除就相乘
        {
            num2 = resultNum%randomOperandNum1;
            if(num2 == 0)
            {
                randomOperandNum2 = resultNum/randomOperandNum1;
                [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum1]];
                [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum2]];
                break;
                
            }
            else
            {
                num2 = randomOperandNum1*resultNum;
                if(num2<randomNum||num2==randomNum)
                {
                    randomOperandNum2 = num2;
                    [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum1]];
                    [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:randomOperandNum2]];
                    break;
                }
            }
        }
    }
    while (1)
    {
        int otherNum = arc4random()%randomNum;
        if(otherNum!=randomOperandNum1&&otherNum!=randomOperandNum2&&otherNum!=resultNum&&otherNum>0)
        {
            [sharedArray.resultAndOperateArray addObject:[NSNumber numberWithInt:otherNum]];
            break;
        }
    }
    return sharedArray.resultAndOperateArray;
}

-(void)dealloc
{
    [super dealloc];
}
@end
