//
//  NHWindow.m
//  NetHack HD
//
//  Created by Dirk Zimmermann on 11/16/11.
//  Copyright (c) 2011 Dirk Zimmermann. All rights reserved.
//

#import "NHWindow.h"

#import "hack.h"

#import "NHMessageLine.h"

@implementation NHWindow

@synthesize type;
@synthesize x;
@synthesize y;

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

@end
