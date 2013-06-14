///
//  CGPointExtension+More.m
//	@see CGPointExtension+More.h for full info
///

#import "CGPointExtension+More.h"
#import "ccMacros.h"

CGPoint ccpLerp(CGPoint a, CGPoint b, float alpha)
{
	return ccpAdd(ccpMult(a, 1.f - alpha), ccpMult(b, alpha));
}

float clampf(float value, float min_inclusive, float max_inclusive)
{
	if (min_inclusive > max_inclusive) {
		CC_SWAP(min_inclusive,max_inclusive);
	}
	return value < min_inclusive ? min_inclusive : value < max_inclusive? value : max_inclusive;
}

CGPoint ccpClamp(CGPoint p, CGPoint min_inclusive, CGPoint max_inclusive)
{
	return ccp(clampf(p.x,min_inclusive.x,max_inclusive.x), clampf(p.y, min_inclusive.y, max_inclusive.y));
}

CGPoint ccpFromSize(CGSize s)
{
	return ccp(s.width, s.height);
}

CGPoint ccpCompOp(CGPoint p, float (*opFunc)(float)){
	return ccp(opFunc(p.x), opFunc(p.y));
}

bool ccpFuzzyEqual(CGPoint a, CGPoint b, float var)
{
	if(a.x - var <= b.x && b.x <= a.x + var)
		if(a.y - var <= b.y && b.y <= a.y + var)
			return true;
	return false;
}

CGPoint ccpCompMult(CGPoint a, CGPoint b)
{
	return ccp(a.x * b.x, a.y * b.y);
}

float ccpAngleSigned(CGPoint a, CGPoint b)
{
	CGPoint a2 = ccpNormalize(a);	CGPoint b2 = ccpNormalize(b);
	float angle = atan2f(a2.x * b2.y - a2.y * b2.x, ccpDot(a2, b2));
	if( fabs(angle) < kCGPointEpsilon ) return 0.f;
	return angle;
}

CGPoint ccpRotateByAngle(CGPoint v, CGPoint pivot, float angle) {
	CGPoint r = ccpSub(v, pivot);
	float t = r.x;
	double cosa = cosf(angle), sina = sinf(angle);
	r.x = t*cosa - r.y*sina;
	r.y = t*sina + r.y*cosa;
	r = ccpAdd(r, pivot);
	return r;
}

bool ccpLineIntersect(CGPoint p1, CGPoint p2, 
					  CGPoint p3, CGPoint p4,
					  float *s, float *t){
	CGPoint p13, p43, p21;
	float d1343, d4321, d1321, d4343, d2121;
	float numer, denom;
	
	p13 = ccpSub(p1, p3);
	
	p43 = ccpSub(p4, p3);
	
	//Roughly equal to zero but with an epsilon deviation for float 
	//correction
	if (ccpFuzzyEqual(p43, CGPointZero, kCGPointEpsilon))
		return false;
	
	p21 = ccpSub(p2, p1);
	
	//Roughly equal to zero
	if (ccpFuzzyEqual(p21,CGPointZero, kCGPointEpsilon))
		return false;
	
	d1343 = ccpDot(p13, p43);
	d4321 = ccpDot(p43, p21);
	d1321 = ccpDot(p13, p21);
	d4343 = ccpDot(p43, p43);
	d2121 = ccpDot(p21, p21);
	
	denom = d2121 * d4343 - d4321 * d4321;
	if (fabs(denom) < kCGPointEpsilon)
		return false;
	numer = d1343 * d4321 - d1321 * d4343;
	
	*s = numer / denom;
	*t = (d1343 + d4321 *(*s)) / d4343;
	
	return true;
}

float ccpAngle(CGPoint a, CGPoint b)
{
	float angle = acosf(ccpDot(ccpNormalize(a), ccpNormalize(b)));
	if( fabs(angle) < kCGPointEpsilon ) return 0.f;
	return angle;
}

