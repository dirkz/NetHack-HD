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

@synthesize tileSize;

- (id)initWithName:(NSString *)n tileSize:(CGSize)ts {
    if ((self = [super init])) {
        tileSize = ts;
        UIImage *image = [UIImage imageNamed:n];
        imageRef = CGImageRetain(image.CGImage);
        columns = image.size.width/tileSize.width;
        rows = image.size.height/tileSize.height;
    }
    return self;
}

- (CGImageRef)createImageWithIndex:(int)index {
    int row = index / columns;
    int col = index % columns;
    NSAssert(col == index - row * columns, @"Modulo calculation of tile differs from difference calculation");
    CGRect r = CGRectMake(col * tileSize.width, row * tileSize.height, tileSize.width, tileSize.height);
    return CGImageCreateWithImageInRect(imageRef, r);
}

- (void)dealloc {
    CGImageRelease(imageRef);
    [super dealloc];
}

@end
