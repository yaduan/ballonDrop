//
//  restartGame.h
//  ballonDrop
//
//  Created by yaduan on 13-3-26.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface restartGameProtocol : CCNode

-(void)pauseLayerDidPause;
-(void)pauseLayerDidUnpause;

@end

@interface restartGame : CCLayer 
{
    restartGameProtocol *delegate;
}
@property (nonatomic,assign)restartGameProtocol *delegete;

+ (id) gameRestart:(id)_delegate;
-(void)start;
-(void)pauseDelegate;
-(id)initWithStart:(id)_delegate;

@end
