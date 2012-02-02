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

@interface MapView () {
    
    /** The area taken away by subviews */
    CGRect subviewBounds;
    
    /** The area taken away by the keyboard */
    CGRect keyboardBounds;
    
}

@property (nonatomic, readonly) CGRect visibleArea;

@end

@implementation MapView

@synthesize map;
@synthesize tileset;

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification *n) {
        CGRect keyboardEndFrame = [[n.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        // convert into view coordinates
        keyboardBounds = [self convertRect:keyboardEndFrame fromView:nil];
//        DLog(@"keyboardBounds %@", NSStringFromCGRect(keyboardBounds));
        [self setNeedsDisplay];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidHideNotification object:nil queue:nil usingBlock:^(NSNotification *n) {
        CGRect keyboardEndFrame = [[n.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        // convert into view coordinates
        keyboardBounds = [self convertRect:keyboardEndFrame fromView:nil];
//        DLog(@"keyboardBounds %@", NSStringFromCGRect(keyboardBounds));
        [self setNeedsDisplay];
    }];
    
}

- (void)drawRect:(CGRect)rect
{
//    DLog(@"visibleArea %@", NSStringFromCGRect(self.visibleArea));
    if (map) {
        
        CGPoint start = CGPointMake(CGRectGetMidX(self.visibleArea), CGRectGetMidY(self.visibleArea));
        start.x -= map.x * tileset.tilesize.width;
        start.y -= map.y * tileset.tilesize.height;
        
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

- (void)layoutSubviews {
    [super layoutSubviews];
    subviewBounds = CGRectZero;
    for (UIView *view in self.subviews) {
        subviewBounds = CGRectUnion(subviewBounds, view.frame);
    }
//    DLog(@"layoutSubviews subviewBounds %@", NSStringFromCGRect(subviewBounds));
}

#pragma mark - Properties

- (CGRect)visibleArea {
    return CGRectMake(0.f, CGRectGetMaxY(subviewBounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(subviewBounds) - CGRectGetHeight(keyboardBounds));
}

@end
