//
//  NHInputHandler.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/3/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

/*
 * NetHack
 * Copyright (C) 2012  Dirk Zimmermann (me AT dirkz DOT com)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#import <Foundation/Foundation.h>

#import "CGPointMath.h"

/** Used by e.g. views to communicate input back to the game */
@protocol NHInputHandler <NSObject>

- (void)handleCharCommand:(char)c sender:(id)sender;
- (void)handleStringCommand:(NSString *)cmd sender:(id)sender;
- (void)handleDirectionTap:(eDirection)direction sender:(id)sender;
- (void)handleDirectionDoubleTap:(eDirection)direction sender:(id)sender;

@end
