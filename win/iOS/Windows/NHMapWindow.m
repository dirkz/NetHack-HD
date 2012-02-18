//
//  NHMapWindow.m
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

#import "NHMapWindow.h"

#import "hack.h"

@implementation NHMapWindow

@synthesize rows;
@synthesize columns;

+ (id)window {
    return [[[self alloc] init] autorelease];
}

- (id)initWithRows:(int)r columns:(int)c {
    if ((self = [super initWithType:NHW_MAP])) {
        rows = r;
        columns = c;
        glyphs = calloc(sizeof(int), rows * columns);
        [self clear];
    }
    return self;
}

- (void)dealloc {
    free(glyphs);
    [super dealloc];
}

- (void)clear {
    for (int i = 0; i < rows * columns; ++i) {
        glyphs[i] = MAX_GLYPH;
    }
}

- (void)setGlyph:(int)g atX:(int)x y:(int)y {
    *(glyphs + y * columns + x) = g;
}

- (int)glyphAtX:(int)x y:(int)y {
    return *(glyphs + y * columns + x);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s: 0x%x type:%d, dim(%d,%d) curs(%d,%d)>", object_getClassName(self), self, [self windowNameFromType:self.type], self.columns, self.rows, self.x, self.y];
}

@end
