//
//  GlobalConfig.m
//  NetHack
//
//  Created by Dirk Zimmermann on 11/7/11.
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

#import "GlobalConfig.h"

static GlobalConfig *s_sharedInstance;

@interface GlobalConfig ()

- (void)triggerObserversForKey:(NSString *)key;

@end

@implementation GlobalConfig

+ (void)setSharedInstance:(id)instance {
    s_sharedInstance = instance;
}

+ (id)sharedInstance {
    return s_sharedInstance;
}

- (void)dealloc {
    [config release];
    [observers release];
    [super dealloc];
}

- (id)init {
    if ((self = [super init])) {
        config = [[NSMutableDictionary alloc] init];
        observers = [[NSMutableDictionary alloc] init];
        [self setBool:[self isGameCenterAPIAvailable] forKey:kGameCenterAvailable];
    }
    return self;
}

- (BOOL)isGameCenterAPIAvailable {
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
    
    // The device must be running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (localPlayerClassAvailable && osVersionSupported);
}

- (void)setObject:(id)o forKey:(NSString *)defaultName {
    [config setObject:o forKey:defaultName];
    [self triggerObserversForKey:defaultName];
}

- (id)objectForKey:(NSString *)defaultName {
    return [config objectForKey:defaultName];
}

- (void)setInt:(int)i forKey:(NSString *)defaultName {
    [config setObject:[NSNumber numberWithInt:i] forKey:defaultName];
    [self triggerObserversForKey:defaultName];
}

- (int)intForKey:(NSString *)defaultName {
    return [[config objectForKey:defaultName] intValue];
}

- (void)setBool:(BOOL)b forKey:(NSString *)defaultName {
    [config setObject:[NSNumber numberWithBool:b] forKey:defaultName];
    [self triggerObserversForKey:defaultName];
}

- (BOOL)boolForKey:(NSString *)defaultName {
    return [[config objectForKey:defaultName] boolValue];
}

- (void)addObserverForKey:(NSString *)key block:(GlobalConfigObservationHandlerBlock)block {
    NSMutableSet *handlers = [observers objectForKey:key];
    if (!handlers) {
        handlers = [[NSMutableSet alloc] initWithCapacity:1];
        [observers setObject:handlers forKey:key];
        [handlers release];
    }
    GlobalConfigObservationHandlerBlock myBlock = [block copy];
    [handlers addObject:myBlock];
    [myBlock release];
}

- (void)triggerObserversForKey:(NSString *)key {
    NSSet *handlers = [observers objectForKey:key];
    for (GlobalConfigObservationHandlerBlock block in handlers) {
        block(self, key);
    }
}

@end
