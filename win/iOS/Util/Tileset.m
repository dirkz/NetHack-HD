//
//  Tileset.m
//  NetHack
//
//  Created by Dirk Zimmermann on 2/2/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

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
