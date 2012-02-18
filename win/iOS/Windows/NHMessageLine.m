//
//  NHMessageLine.m
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

#import "NHMessageLine.h"

@implementation NHMessageLine

@synthesize message;
@synthesize attribute;

+ (id)messageLineWithCString:(const char *)s attribute:(int)a {
    return [[[self alloc] initWithCString:s attribute:a] autorelease];
}

- (id)initWithCString:(const char *)s attribute:(int)a {
    if ((self = [super init])) {
        message = [NSString stringWithCString:s encoding:NSASCIIStringEncoding];
        message = [message stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        message = [message stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        message = [message copy];
        attribute = a;
    }
    return self;
}

- (void)dealloc {
    [message release];
    [super dealloc];
}

@end
