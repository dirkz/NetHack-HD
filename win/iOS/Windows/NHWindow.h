//
//  NHWindow.h
//  NetHack
//
//  Created by Dirk Zimmermann on 11/16/11.
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

#import <Foundation/Foundation.h>

#import "NHCondition.h"

@class NHMessageLine;

@interface NHWindow : NHCondition {
    
    NSMutableArray *messageLines;
    
}

@property (nonatomic, readonly) int type;

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;

@property (nonatomic, readonly) NSArray *messageLines;
@property (nonatomic, readonly) NSArray *messageStrings;
@property (nonatomic, readonly) NSUInteger numberOfMessages;
@property (nonatomic, readonly) NSString *text;

- (id)initWithType:(int)t;

- (NSString *)windowNameFromType:(int)t;
- (void)clear;
- (void)clipAroundX:(int)x y:(int)y;

- (void)addCString:(const char *)s withAttribute:(int)attr;
- (void)addCString:(const char *)s;

- (NHMessageLine *)messageLineAtIndex:(NSUInteger)i;
- (NSString *)messageStringAtIndex:(NSUInteger)i;

@end
