//
//  MapView.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/2/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NHMapWindow;
@class Tileset;

@interface MapView : UIView

@property (nonatomic, assign) NHMapWindow *map;
@property (nonatomic, assign) Tileset *tileset;

@end
