//
//  MapView.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/2/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapView;
@class NHPoskey;

@protocol MapViewDelegate <NSObject>

- (void)mapView:(MapView *)mapView poskey:(NHPoskey *)poskey;

@end

@class NHMapWindow;
@class Tileset;

@interface MapView : UIView

@property (nonatomic, assign) NHMapWindow *map;
@property (nonatomic, assign) Tileset *tileset;
@property (nonatomic, assign) id<MapViewDelegate> delegate;

/** The tile rect where the player is, in local view coordinates.
 * Will return the map center if there's currently no player position.
 */
@property (nonatomic, readonly) CGRect playerRect;

@end
