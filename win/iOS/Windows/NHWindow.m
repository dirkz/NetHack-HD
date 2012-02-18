//
//  NHWindow.m
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

#import "NHWindow.h"

#import "hack.h"

#import "NHMessageLine.h"

@implementation NHWindow

@synthesize type;
@synthesize x;
@synthesize y;
@synthesize text;

@synthesize messageLines;

- (id)initWithType:(int)t {
    if ((self = [super init])) {
        type = t;
        messageLines = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [messageLines release];
    [super dealloc];
}

- (void)clear {
    [messageLines removeAllObjects];
}

- (NSString *)windowNameFromType:(int)t {
    switch (t) {
        case NHW_MESSAGE:
            return @"NHW_MESSAGE";
        case NHW_STATUS:
            return @"NHW_STATUS";
        case NHW_MAP:
            return @"NHW_MAP";
        case NHW_MENU:
            return @"NHW_MENU";
        case NHW_TEXT:
            return @"NHW_TEXT";
        default:
            return @"UNKNOWN";
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s: 0x%x type:%d>", object_getClassName(self), self, [self windowNameFromType:self.type]];
}

- (void)clipAroundX:(int)i y:(int)j {
    x = i;
    y = j;
}

- (void)addCString:(const char *)s withAttribute:(int)attr {
    [messageLines addObject:[NHMessageLine messageLineWithCString:s attribute:attr]];
}

- (void)addCString:(const char *)s {
    [self addCString:s withAttribute:ATR_NONE];
}

- (NHMessageLine *)messageLineAtIndex:(NSUInteger)i {
    return [messageLines objectAtIndex:i];
}

- (NSString *)messageStringAtIndex:(NSUInteger)i {
    NHMessageLine *line = [self messageLineAtIndex:i];
    return line.message;
}

#pragma mark - Properties

- (NSUInteger)numberOfMessages {
    return messageLines.count;
}

- (NSArray *)messageStrings {
    NSMutableArray *lines = [NSMutableArray arrayWithCapacity:self.numberOfMessages];
    for (NHMessageLine *line in self.messageLines) {
        [lines addObject:line.message];
    }
    return lines;
}

- (NSString *)text {
    NSArray *lines = [self messageStrings];
    return [lines componentsJoinedByString:@"\n"];
}

@end
