///
//  CGPointExtension+More.h
//
//  Created by Lam Pham on 20/10/09.
///

#import <Foundation/Foundation.h>
#import "CGPointExtension.h"

#ifdef __cplusplus
extern "C" {
#endif	
	
#define kCGPointEpsilon		0.0001f
	
	///
	//	Clamp a value between from and to.
	///
	float clampf(float value, float min_inclusive, float max_inclusive);
	
	///
	//	Clamp a point between from and to.
	///
	CGPoint ccpClamp(CGPoint p, CGPoint from, CGPoint to);
	
	///
	//	Quickly convert CGSize to a CGPoint
	///
	CGPoint ccpFromSize(CGSize s);
	
	///
	//	Run a math operation function on each point component
	//	absf, fllorf, ceilf, roundf
	//	any function that has the signature: float func(float);
	//	For example: let's try to take the floor of x,y
	//	ccpCompOp(p,floorf);
	///
	CGPoint ccpCompOp(CGPoint p, float (*opFunc)(float));
	
	///
	//	Linear Interpolation between two points a and b
	//	@returns
	//		alpha == 0 ? a
	//		alpha == 1 ? b
	//		otherwise a value between a..b
	///
	CGPoint ccpLerp(CGPoint a, CGPoint b, float alpha);
		
	///
	//	@returns if points have fuzzy equality which means equal with some degree
	//	of variance.
	///
	bool ccpFuzzyEqual(CGPoint a, CGPoint b, float variance);
	
	///
	//	Multiplies a nd b components, a.x*b.x, a.y*b.y
	//	@returns a component-wise multiplication
	///
	CGPoint ccpCompMult(CGPoint a, CGPoint b);
	
	///
	//	@returns the signed angle in radians between two vector directions
	///
	float ccpAngleSigned(CGPoint a, CGPoint b);
	
	///
	//	@returns the angle in radians between two vector directions
	///
	float ccpAngle(CGPoint a, CGPoint b);
	
	///
	//	Rotates a point counter clockwise by the angle around a pivot
	//	@param v is the point to rotate
	//	@param pivot is the pivot, naturally
	//	@param angle is the angle of rotation cw in radians
	//	@returns the rotated point
	///
	CGPoint ccpRotateByAngle(CGPoint v, CGPoint pivot, float angle);
		
	///
	// A general line-line intersection test
	// @params p1 
	//		is the startpoint for the first line P1 = (p1 - p2)
	// @params p2 
	//		is the endpoint for the first line P1 = (p1 - p2)
	// @params p3 
	//		is the startpoint for the second line P2 = (p3 - p4)
	// @params p4 
	//		is the endpoint for the second line P2 = (p3 - p4)
	// @params s 
	//		is the range for a hitpoint in P1 (pa = p1 + s*(p2 - p1))
	// @params t
	//		is the range for a hitpoint in P3 (pa = p2 + t*(p4 - p3))
	// @return bool 
	//		indicating successful intersection of a line
	//		note that to truly test intersection for segments we have to make 
	//		sure that s & t lie within [0..1] and for rays, make sure s & t > 0
	//		the hit point is		p3 + t * (p4 - p3);
	//		the hit point also is	p1 + s * (p2 - p1);
	///
	bool ccpLineIntersect(CGPoint p1, CGPoint p2, 
									 CGPoint p3, CGPoint p4,
									 float *s, float *t);
#ifdef __cplusplus
}
#endif