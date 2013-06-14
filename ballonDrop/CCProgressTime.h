///
//  ProgressTimer.h
//
//  Created by Lam Pham on 23/10/09.
//
//	Simple Progress timer. Shows a percentage of the image based on the
//	percentage property.
///
#import <Foundation/Foundation.h>
#import "CCSprite.h"

typedef enum {
	kProgressTimerTypeRadialCCW,
	kProgressTimerTypeRadialCW,
	kProgressTimerTypeHorizontalBarLR,
	kProgressTimerTypeHorizontalBarRL,
	kProgressTimerTypeVerticalBarBT,
	kProgressTimerTypeVerticalBarTB,
} CCProgressTimerType;

@interface CCProgressTime : CCNode {
	CCProgressTimerType	type_;
	float				percentage_;
	CCSprite			*sprite_;
	
	int					vertexDataCount_;
	ccV2F_C4F_T2F		*vertexData_;
}
///
//	Change the percentage to change progress.
///
@property CCProgressTimerType type;

///
//	Percentages are from 0 to 100
///
@property float percentage;

///
//	The image to show the progress percentage
///
@property (retain) CCSprite *sprite;

///
//	Creates a progress timer with the texture as the shape the timer goes through
///
+ (id) progressWithFile:(NSString*) filename;
- (id) initWithFile:(NSString*) filename;

+ (id) progressWithTexture:(CCTexture2D*) texture;
- (id) initWithTexture:(CCTexture2D*) texture;

@end
