//
//  NHCondition.m
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

#import "NHCondition.h"

@implementation NHCondition

@synthesize finished;

- (id)init {
    if ((self = [super init])) {
        condition = [[NSCondition alloc] init];
    }
    return self;
}

- (void)wait {
    [condition lock];
    while (!self.finished) {
        [condition wait];
    }
    [condition unlock];
}

- (void)signal {
    [condition lock];
    finished = YES;
    [condition signal];
    [condition unlock];
}

- (void)dealloc {
    [condition release];
    [super dealloc];
}

@end
