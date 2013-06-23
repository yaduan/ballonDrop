//
//  record.m
//  ballonDrop
//
//  Created by yaduan on 13-4-12.
//
//

#import "record.h"
#import "initGameScene.h"

@implementation record
@synthesize listData;

-(record *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    [self setAlpha:0.9];

    [self setBackgroundColor:MainBackgroundColor];
    [self setBackgroundColor:[UIColor yellowColor]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, 600, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Marker Felt" size:16];
    titleLabel.text = @"                                      Data                                           totalNum               doRight";
    titleLabel.textColor = [UIColor blueColor];
    [self addSubview:titleLabel];
    
    shared = [Shared shared];
    self.listData = shared.recordDataArray;
    table = [[UITableView alloc]initWithFrame:CGRectMake(30, 100, 600,300)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor clearColor];
    table.separatorColor = [UIColor clearColor];
    [self addSubview:table];
   
    
    
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
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];;
    button1.frame = CGRectMake(120.0f, 460.0f, 80.0f, 32.0f);
    [button1 setTitle:@"clear" forState:UIControlStateHighlighted];
    [button1 setTitle:@"clear" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clearData) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];
    
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
    
    [initGameScene endButtonTapped];
}

-(void)clearData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"duanduan"];
    NSString *logPath = [appFile stringByAppendingPathComponent:@"file.txt"];
    [[NSFileManager defaultManager] removeItemAtPath:logPath error:nil];
    shared.recordDataArray = nil;
    self.listData = nil;
    [table reloadData];
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
     //   cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString] autorelease];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:14];
    cell.textLabel.textColor = [UIColor blueColor];
    // cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"66.png"]];
    cell.textLabel.center = tableView.center;
    tableView.editing=NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  //  [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    return cell;
}

- (void)dealloc
{
    NSLog(@"record");
    listData = nil;
    [listData release];
    [super dealloc];
}


@end
