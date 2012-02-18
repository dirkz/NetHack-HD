//
//  Tileset.m
//  NetHack
//
//  Created by Dirk Zimmermann on 2/2/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
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

#import "Tileset.h"

@interface Tileset () {
    
    CGImageRef imageRef;
    int rows;
    int columns;
    
}

@end

@implementation Tileset

@synthesize tilesize;

- (id)initWithName:(NSString *)n tileSize:(CGSize)ts {
    if ((self = [super init])) {
        tilesize = ts;
        UIImage *image = [UIImage imageNamed:n];
        imageRef = CGImageRetain(image.CGImage);
        columns = image.size.width/tilesize.width;
        rows = image.size.height/tilesize.height;
    }
    return self;
}

- (CGImageRef)createImageWithIndex:(int)index {
    int row = index / columns;
    int col = index % columns;
    NSAssert(col == index - row * columns, @"Modulo calculation of tile differs from difference calculation");
    CGRect r = CGRectMake(col * tilesize.width, row * tilesize.height, tilesize.width, tilesize.height);
    return CGImageCreateWithImageInRect(imageRef, r);
}

- (void)dealloc {
    CGImageRelease(imageRef);
    [super dealloc];
}

@end
