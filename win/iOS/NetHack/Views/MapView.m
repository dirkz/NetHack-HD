//
//  MapView.m
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

#import "MapView.h"

#import "NHMapWindow.h"
#import "Tileset.h"

#include "hack.h"

#import "CGPointMath.h"
#import "NHInputHandler.h"

extern short glyph2tile[MAX_GLYPH];

@interface MapView () {
    
}

@property (nonatomic, readonly) CGPoint drawStart;

@end

@implementation MapView

@synthesize map;
@synthesize tileset;
@synthesize inputHandler;

- (void)awakeFromNib {
    {
        UITapGestureRecognizer *stgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
        stgr.numberOfTapsRequired = 1;
        [self addGestureRecognizer:stgr];
        [stgr release];
    }

    {
        UITapGestureRecognizer *dtgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
        dtgr.numberOfTapsRequired = 2;
        [self addGestureRecognizer:dtgr];
        [dtgr release];
    }
}

- (void)drawRect:(CGRect)rect
{
    if (map) {
        CGPoint start = self.drawStart;
        
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor grayColor].CGColor);
        CGRect all = CGRectInset(CGRectMake(0.f, 0.f, tileset.tilesize.width * map.columns, tileset.tilesize.height * map.rows), -20.f, -20.f);
        CGContextStrokeRect(UIGraphicsGetCurrentContext(), all);
        
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

        // hp100 calculation from qt_win.cpp
        int hp100;
        if (u.mtimedone) {
            hp100 = u.mhmax ? u.mh*100/u.mhmax : 100;
        } else {
            hp100 = u.uhpmax ? u.uhp*100/u.uhpmax : 100;
        }
        
        UIColor *playerColor = nil;
        if (hp100 > 75) {
            playerColor = [UIColor greenColor];
        } else if (hp100 <= 75 && hp100 > 50) {
            playerColor = [UIColor colorWithRed:0.f green:0.7f blue:0.f alpha:1.f];
        } else if (hp100 <= 50 && hp100 > 25) {
            playerColor = [UIColor orangeColor];
        } else {
            playerColor = [UIColor redColor];
        }
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), playerColor.CGColor);
        CGContextStrokeRect(UIGraphicsGetCurrentContext(), self.playerRect);
    }
}

#pragma mark - UIGestureRecognizer

- (char)directionFromGestureRecognizer:(UIGestureRecognizer *)gr {
    CGRect player = self.playerRect;
    CGPoint playerCenter = CGPointMake(CGRectGetMidX(player), CGRectGetMidY(player));
    
    CGPoint delta = CGPointDelta([gr locationInView:gr.view], playerCenter);
    return CGPointDirectionFromUIKitDelta(delta);
}

- (void)handleSingleTapGesture:(UITapGestureRecognizer *)gr {
    eDirection direction = [self directionFromGestureRecognizer:gr];
    [inputHandler handleDirectionTap:direction sender:self];
}

- (void)handleDoubleTapGesture:(UITapGestureRecognizer *)gr {
    eDirection direction = [self directionFromGestureRecognizer:gr];
    [inputHandler handleDirectionDoubleTap:direction sender:self];
}

#pragma mark - Properties

- (CGRect)playerRect {
    if (map) {
        CGPoint start = self.drawStart;
        return CGRectMake(start.x + map.x * tileset.tilesize.width,
                          start.y + map.y * tileset.tilesize.height,
                          tileset.tilesize.width, tileset.tilesize.height);
    } else {
        // return a rectangle around the center
        CGRect r = CGRectMake(roundf(self.bounds.size.width/2), roundf(self.bounds.size.height/2), 0.f, 0.f);
        r = CGRectInset(r, tileset.tilesize.width/2, tileset.tilesize.height/2);
        return r;
    }
}

- (CGPoint)drawStart {
    CGPoint start = CGPointMake(roundf(self.bounds.size.width/2 + tileset.tilesize.width/2 - map.x * tileset.tilesize.width),
                                roundf(self.bounds.size.height/2 + tileset.tilesize.height/2 - map.y * tileset.tilesize.height));
    return start;
}

@end
