///
//  ProgressTimer+Actions.h
//
//  Created by Lam Pham on 27/10/09.
//
//	Actions for progress timer.
///

#import <Foundation/Foundation.h>
#import "CCProgressTimer.h"
//#import "CCIntervalAction.h"

///
//	Progress to percentage
///
@interface CCProgressTo : CCIntervalAction <NSCopying>
{
	float to;
	float from;
}
+(id) actionWithDuration:(ccTime)duration percent:(float)percent;
-(id) initWithDuration:(ccTime)duration percent:(float)percent;
@end

///
//	Progress from a percentage to another percentage
///
@interface CCProgressFromTo : CCIntervalAction <NSCopying>
{
	float to;
	float from;
}
+(id) actionWithDuration:(ccTime)duration from:(float)fromPercentage to:(float) toPercentage;
-(id) initWithDuration:(ccTime)duration from:(float)fromPercentage to:(float) toPercentage;
@end