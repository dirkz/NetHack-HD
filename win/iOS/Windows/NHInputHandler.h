//
//  NHInputHandler.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/3/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CGPointMath.h"

/** Used by e.g. views to communicate input back to the game */
@protocol NHInputHandler <NSObject>

- (void)handleCharCommand:(char)c sender:(id)sender;
- (void)handleStringCommand:(NSString *)cmd sender:(id)sender;
- (void)handleDirectionTap:(eDirection)direction sender:(id)sender;
- (void)handleDirectionDoubleTap:(eDirection)direction sender:(id)sender;

@end
