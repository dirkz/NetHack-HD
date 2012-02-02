//
//  Tileset.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/2/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tileset : NSObject

@property (nonatomic, readonly) CGSize tileSize;


- (id)initWithName:(NSString *)n tileSize:(CGSize)ts;

/**
 * Creates CGImageRef with CGImageCreateWithImageInRect with the given index.
 * Use CGImageRelease() when finished with this image.
 */
- (CGImageRef)createImageWithIndex:(int)index;

@end
