//
//  aboutGame.m
//  ballonDrop
//
//  Created by yaduan on 13-6-21.
//
//

#import "aboutGame.h"

@implementation aboutGame

-(aboutGame *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect] ;
    [self setAlpha:0.9];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    UILabel *labelone = [[UILabel alloc]initWithFrame:CGRectMake(60,10, 500, 30)];   //原来这里都为全局变量
    labelone.backgroundColor = [UIColor clearColor];
    labelone.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:28];
    labelone.text = @"1.点击选取运算类型";
    labelone.textColor = [UIColor blueColor];
    [self addSubview:labelone];
   
    UILabel *labeltwo = [[UILabel alloc]initWithFrame:CGRectMake(80,80, 500, 30)];
    labeltwo.backgroundColor = [UIColor clearColor];
    labeltwo.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:28];
    labeltwo.text = @"2.点击选取范围";
    labeltwo.textColor = [UIColor blueColor];
    [self addSubview:labeltwo];
    
    UILabel *labelthree = [[UILabel alloc]initWithFrame:CGRectMake(50,150, 500, 30)];
    labelthree.backgroundColor = [UIColor clearColor];
    labelthree.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:28];
    labelthree.text = @"3.点击reset重新选择";
    labelthree.textColor = [UIColor blueColor];
    [self addSubview:labelthree];
    
    UILabel *labelfour = [[UILabel alloc]initWithFrame:CGRectMake(40,220, 500, 30)];
    labelfour.backgroundColor = [UIColor clearColor];
    labelfour.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:28];
    labelfour.text = @"4.点击ok进入游戏界面";
    labelfour.textColor = [UIColor blueColor];
    [self addSubview:labelfour];
    
    UILabel *labelfive = [[UILabel alloc]initWithFrame:CGRectMake(0,290, 500, 30)];
    labelfive.backgroundColor = [UIColor clearColor];
    labelfive.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:28];
    labelfive.text = @"5.游戏左上角出现结果数，例如 9";
    labelfive.textColor = [UIColor blueColor];
    [self addSubview:labelfive];
    
    UILabel *labelsix = [[UILabel alloc]initWithFrame:CGRectMake(10,360, 500, 30)];
    labelsix.backgroundColor = [UIColor clearColor];
    labelsix.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:28];
    labelsix.text = @"6.手指滑中3个气球，例如 4 + 5";
    labelsix.textColor = [UIColor blueColor];
    [self addSubview:labelsix];
    
    UILabel *labelseven = [[UILabel alloc]initWithFrame:CGRectMake(45,430, 500, 30)];
    labelseven.backgroundColor = [UIColor clearColor];
    labelseven.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:28];
    labelseven.text = @"7.让我们开始吧 宝贝";
    labelseven.textColor = [UIColor blueColor];
    [self addSubview:labelseven];
    
    [labelone release];
    [labeltwo release];
    [labelthree release];
    [labelfour release];
    [labelfive release];
    [labelsix release];
    [labelseven release];
    
    return self ;
}

-(void)removeView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:5.0f];
    CGRect rect = [self frame];
    rect.origin.y = 786;
    [self setFrame:rect];
    [UIView commitAnimations];
}

-(void)presentView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:5.0f];
    
    CGRect rect = [self frame];
    rect.origin.y = 130;
    [self setFrame:rect];
    [UIView commitAnimations];
}

@end
