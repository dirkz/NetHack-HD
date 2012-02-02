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

/** The tile rect where the player is, in local view coordinates.
 * Will return the map center if there's currently no player position.
 */
@property (nonatomic, readonly) CGRect playerRect;

@end
