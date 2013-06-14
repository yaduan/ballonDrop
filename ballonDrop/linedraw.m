//
//  linedraw.m
//  ballonDrop
//
//  Created by yaduan on 13-4-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "linedraw.h"


@implementation linedraw

@synthesize startPoint;
@synthesize endPoint;

-(void)draw
{
    glLineWidth(2.0f);
    glColorMask(1.0f, 0.0f, 0.0f, 1.0f);
    glDisable(GL_TEXTURE_2D);
    
  //  CGFloat ver[4]=(startPoint.x,startPoint.y,endPoint.x,endPoint.y);
  //  glDrawArrays(GL_LINES, 0, 2);
    
    
}

@end
