//
//  NHStatusWindow.m
//  NetHack HD
//
//  Created by Dirk Zimmermann on 11/16/11.
//  Copyright (c) 2011 Dirk Zimmermann. All rights reserved.
//

#import "NHStatusWindow.h"

#import "NHMessageLine.h"

@implementation NHStatusWindow

+ (id)window {
    return [[[self alloc] init] autorelease];
}

- (id)init {
    if ((self = [super initWithType:NHW_STATUS])) {
        [self clear];
    }
    return self;
}

- (void)clear {
    // make sure we have exactly 2 lines in messages
    [messageLines removeAllObjects];
    [messageLines addObject:[NSNull null]];
    [messageLines addObject:[NSNull null]];
}

- (void)addCString:(const char *)s withAttribute:(int)attr {
    [messageLines replaceObjectAtIndex:self.y withObject:[NHMessageLine messageLineWithCString:s attribute:attr]];
}

@end
