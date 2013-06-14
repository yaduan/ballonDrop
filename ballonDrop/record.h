//
//  record.h
//  ballonDrop
//
//  Created by yaduan on 13-4-12.
//
//

#import <Foundation/Foundation.h>
#import "Shared.h"

#define MainBackgroundColor [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg%d",arc4random()%7]]]

@interface record : UIView <UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    Shared *shared;
}

@property (nonatomic,retain) NSArray *listData;
-(record *)initWithFrame:(CGRect)rect;
-(void)removeView;
-(void)presentView;

@end
