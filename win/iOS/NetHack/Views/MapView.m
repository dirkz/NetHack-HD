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

- (void)awakeFromNib {
}

- (void)drawRect:(CGRect)rect
{
    if (map) {
        CGPoint start = CGPointMake(self.bounds.size.width/2 + tileset.tilesize.width/2 - map.x * tileset.tilesize.width,
                                    self.bounds.size.height/2 + tileset.tilesize.height/2 - map.y * tileset.tilesize.height);
        
        for (int j = 0; j < map.rows; ++j) {
            for (int i = 0; i < map.columns; ++i) {
                int glyph = [map glyphAtX:i y:j];
                if (glyph != NO_GLYPH) {
                    int tile = glyph2tile[glyph];
                    CGImageRef imageRef = [tileset createImageWithIndex:tile];
                    UIImage *image = [UIImage imageWithCGImage:imageRef];
                    CGRect r = CGRectMake(start.x + i * tileset.tilesize.width, start.y + j * tileset.tilesize.height, tileset.tilesize.width, tileset.tilesize.height);
                    [image drawInRect:r];
                }
            }
        }
    }
}

#pragma mark - Properties

- (CGRect)playerRect {
    if (map) {
        return CGRectMake(self.bounds.size.width/2 - map.x * tileset.tilesize.width,
                          self.bounds.size.height/2 - map.y * tileset.tilesize.height,
                          tileset.tilesize.width, tileset.tilesize.height);
    } else {
        CGRect r = CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, 0.f, 0.f);
        r = CGRectInset(r, tileset.tilesize.width/2, tileset.tilesize.height/2);
        return r;
    }
}

@end
