///
//  ProgressTimer+Actions.m
//
//  Created by Lam Pham on 27/10/09.
///

#import "CCProgressTimer+Actions.h"

#define kProgressTimerCast CCProgressTimer*

@implementation CCProgressTo
+(id) actionWithDuration: (ccTime) t percent: (float) v
{
	return [[[ self alloc] initWithDuration: t percent: v] autorelease];
}

-(id) initWithDuration: (ccTime) t percent: (float) v
{
	if( (self=[super initWithDuration: t] ) )
		to = v;
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration: [self duration] percent: to];
	return copy;
}

-(void) startWithTarget:(id) aTarget;
{
	[super startWithTarget:aTarget];
	from = [(kProgressTimerCast)target percentage];
}

-(void) update: (ccTime) t
{
	[(kProgressTimerCast)target setPercentage: from + ( to - from ) * t];
}
@end

@implementation CCProgressFromTo
+(id) actionWithDuration: (ccTime) t from:(float)fromPercentage to:(float) toPercentage
{
	return [[[ self alloc] initWithDuration: t from: fromPercentage to: toPercentage] autorelease];
}

-(id) initWithDuration: (ccTime) t from:(float)fromPercentage to:(float) toPercentage
{
	if( (self=[super initWithDuration: t] ) ){
		to = toPercentage;
		from = fromPercentage;
	}
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration: [self duration] from: from to: to];
	return copy;
}

-(void) startWithTarget:(id) aTarget;
{
	[super startWithTarget:aTarget];
}

-(void) update: (ccTime) t
{
	[(kProgressTimerCast)target setPercentage: from + ( to - from ) * t];
}
@end