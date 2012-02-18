//
//  NHMenuItem.m
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

#import "NHMenuItem.h"

@implementation NHMenuItem

@synthesize glyph;
@synthesize identifier;
@synthesize accelerator;
@synthesize groupAccelerator;
@synthesize attribute;
@synthesize name;
@synthesize preselected;
@synthesize menuItems;

+ (id)menuItemWithGlyph:(int)g identifier:(ANY_P)i accelerator:(CHAR_P)acc groupAccelerator:(CHAR_P)gAcc attribute:(int)a nameCString:(const char *)n preselected:(BOOL)presel {
    return [[[self alloc] initWithGlyph:g identifier:i accelerator:acc groupAccelerator:gAcc attribute:a nameCString:n preselected:presel] autorelease];
}

- (id)initWithGlyph:(int)g identifier:(ANY_P)i accelerator:(CHAR_P)acc groupAccelerator:(CHAR_P)gAcc attribute:(int)a nameCString:(const char *)n preselected:(BOOL)presel {
    if ((self = [super init])) {
        glyph = g;
        identifier = i;
        if (self.isParent) {
            menuItems = [[NSMutableArray alloc] init];
        }
        accelerator = acc;
        groupAccelerator = gAcc;
        attribute = a;
        name = [[NSString alloc] initWithCString:n encoding:NSASCIIStringEncoding];
        preselected = presel;
    }
    return self;
}

- (void)dealloc {
    [name release];
    [menuItems release];
    [super dealloc];
}

- (void)addMenuItem:(NHMenuItem *)child {
    [menuItems addObject:child];
}

#pragma mark - Properties

- (NSUInteger)numberOfMenuItems {
    return menuItems.count;
}

- (BOOL)isParent {
    return identifier.a_obj == 0;
}

@end
