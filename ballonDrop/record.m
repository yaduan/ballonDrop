//
//  record.m
//  ballonDrop
//
//  Created by yaduan on 13-4-12.
//
//

#import "record.h"

@implementation record
@synthesize listData;

-(record *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect] ;
    [self setAlpha:0.9];
    [self setBackgroundColor:MainBackgroundColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, 600, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Marker Felt" size:16];
    titleLabel.text = @"                                      Data                                           totalNum               doRight";
    titleLabel.textColor = [UIColor blueColor];
    [self addSubview:titleLabel];
    
    shared = [Shared shared];
    self.listData = shared.recordDataArray;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, 100, 600,300)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor clearColor];
    [self addSubview:tableView];
   
    
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(30, 400, 600, 50)];
    message.lineBreakMode = UILineBreakModeWordWrap;
    message.text = @"Baby, are you tired? After a good rest, remember to continue refueling Oh!";
    message.textColor = [UIColor blackColor];
    message.backgroundColor = [UIColor clearColor];
    message.textAlignment = UITextAlignmentCenter ;
    message.font = [UIFont fontWithName:@"Marker Felt" size:20];
    message.textColor = [UIColor blueColor];
    [self addSubview:message];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];;
    button.frame = CGRectMake(520.0f, 460.0f, 80.0f, 32.0f);
    [button setTitle:@"OKay" forState:UIControlStateHighlighted];
    [button setTitle:@"OKay" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return self ;
}

-(void)removeView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5f];
    
    CGRect rect = [self frame];
    rect.origin.y = -10.0f - rect.size.height;
    [self setFrame:rect];
    
    [UIView commitAnimations];
}

-(void)presentView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5f];
    
    CGRect rect = [self frame];
    rect.origin.y = 0.0;
    [self setFrame:rect];
    
    [UIView commitAnimations];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.listData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellString = @"cellString";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString] autorelease];
    }
    
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:14];
    cell.textLabel.textColor = [UIColor blueColor];
    // cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"66.png"]];
    cell.textLabel.center = tableView.center;
    tableView.editing=NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    return cell;
}

- (void)dealloc
{
    listData = nil;
    [listData release];
    [super dealloc];
}


@end
