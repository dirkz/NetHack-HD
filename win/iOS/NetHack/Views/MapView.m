//
//  MapView.m
//  NetHack
//
//  Created by Dirk Zimmermann on 2/2/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#import "MapView.h"

#import "NHMapWindow.h"
#import "Tileset.h"

#include "hack.h"

extern short glyph2tile[MAX_GLYPH];

@implementation MapView

@synthesize map;
@synthesize tileset;

- (void)drawRect:(CGRect)rect
{
    for (int j = 0; j < map.rows; ++j) {
        for (int i = 0; i < map.columns; ++i) {
            int glyph = [map glyphAtX:i y:j];
            if (glyph != NO_GLYPH) {
                int tile = glyph2tile[glyph];
                CGImageRef imageRef = [tileset createImageWithIndex:tile];
                CGRect r = CGRectMake(i * tileset.tileSize.width, j * tileset.tileSize.height, tileset.tileSize.width, tileset.tileSize.height);
                CGContextDrawImage(UIGraphicsGetCurrentContext(), r, imageRef);
                CGImageRelease(imageRef);
            }
        }
    }
}

@end
