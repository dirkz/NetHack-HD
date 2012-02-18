//
//  NHPoskey.m
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

#import "NHPoskey.h"

@implementation NHPoskey

@synthesize key;
@synthesize x;
@synthesize y;
@synthesize mod;
@synthesize isDirection;

+ (id)poskey {
    return [[[self alloc] init] autorelease];
}

+ (id)poskeyWithKey:(char)k {
    return [[[self alloc] initWithKey:k] autorelease];
}

- (id)initWithKey:(char)k {
    if ((self = [super init])) {
        self.key = k;
    }
    return self;
}

- (void)clear {
    x = 0;
    y = 0;
    mod = 0;
    key = 0;
}

- (void)updateWithKey:(char)k {
    [self clear];
    key = k;
}

- (void)updateWithX:(int)i y:(int)j {
    [self clear];
    x = i;
    y = j;
}

@end
