//
//  NHPoskey.h
//  NetHack
//
//  Created by Dirk Zimmermann on 11/17/11.
//  Copyright (c) 2011 Dirk Zimmermann. All rights reserved.
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

#import "NHCondition.h"

@interface NHPoskey : NHCondition

@property (nonatomic, assign) char key;
@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, assign) int mod;
@property (nonatomic, assign) BOOL isDirection;

+ (id)poskey;
+ (id)poskeyWithKey:(char)k;

- (id)initWithKey:(char)k;
- (void)updateWithKey:(char)k;
- (void)updateWithX:(int)i y:(int)j;

@end
