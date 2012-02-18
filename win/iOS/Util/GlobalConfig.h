//
//  GlobalConfig.h
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

#import <Foundation/Foundation.h>

@class GlobalConfig;
typedef void (^GlobalConfigObservationHandlerBlock)(GlobalConfig *config, NSString *key);

#define kGameCenterAvailable (@"GameCenterAvailable")

@interface GlobalConfig : NSObject {
    
    NSMutableDictionary *config;
    NSMutableDictionary *observers;
    
}

+ (void)setSharedInstance:(id)instance;
+ (id)sharedInstance;

- (BOOL)isGameCenterAPIAvailable;

- (void)setObject:(id)o forKey:(NSString *)defaultName;
- (id)objectForKey:(NSString *)defaultName;
- (void)setInt:(int)i forKey:(NSString *)defaultName;
- (int)intForKey:(NSString *)defaultName;
- (void)setBool:(BOOL)b forKey:(NSString *)defaultName;
- (BOOL)boolForKey:(NSString *)defaultName;

- (void)addObserverForKey:(NSString *)key block:(GlobalConfigObservationHandlerBlock)block;

@end
