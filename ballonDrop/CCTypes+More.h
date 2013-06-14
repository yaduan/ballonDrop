/*
 *  CCTypes+More.h
 *  PixelPile
 *
 *  Created by Lam Pham on 23/10/09.
 *  Copyright 2009 FancyRatStudios. All rights reserved.
 *
 */

#import "ccTypes.h"

#ifdef __cplusplus
extern "C" {
#endif
	
	static inline ccColor4F ccc4FFromccc3B(ccColor3B c)
	{
		return (ccColor4F){c.r/255.f, c.g/255.f, c.b/255.f, 1.f};
	}
	
	static inline ccColor4F ccc4FFromccc4B(ccColor4B c)
	{
		return (ccColor4F){c.r/255.f, c.g/255.f, c.b/255.f, c.a/255.f};
	}
	
	static inline bool ccc4FEqual(ccColor4F a, ccColor4F b)
	{
		return a.r == b.r && a.g == b.g && a.b == b.b && a.a == b.a;
	}
	
#ifdef __cplusplus
}
#endif
