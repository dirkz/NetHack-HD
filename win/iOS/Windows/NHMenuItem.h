//
//  NHMenuItem.h
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

#import <Foundation/Foundation.h>

#import "hack.h"

@interface NHMenuItem : NSObject {
    
    NSMutableArray *menuItems;
    
}

@property (nonatomic, readonly) int glyph;
@property (nonatomic, readonly) ANY_P identifier;
@property (nonatomic, readonly) CHAR_P accelerator;
@property (nonatomic, readonly) CHAR_P groupAccelerator;
@property (nonatomic, readonly) int attribute;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) BOOL preselected;
@property (nonatomic, readonly) NSArray *menuItems;
@property (nonatomic, readonly) NSUInteger numberOfMenuItems;
@property (nonatomic, readonly) BOOL isParent;

+ (id)menuItemWithGlyph:(int)g identifier:(ANY_P)i accelerator:(CHAR_P)acc groupAccelerator:(CHAR_P)gAcc attribute:(int)a nameCString:(const char *)n preselected:(BOOL)presel;

- (id)initWithGlyph:(int)g identifier:(ANY_P)i accelerator:(CHAR_P)acc groupAccelerator:(CHAR_P)gAcc attribute:(int)a nameCString:(const char *)n preselected:(BOOL)presel;
- (void)addMenuItem:(NHMenuItem *)child;

@end
