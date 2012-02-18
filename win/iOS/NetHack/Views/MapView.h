//
//  MapView.h
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

#import <UIKit/UIKit.h>

#import "NHInputHandler.h"

@class NHMapWindow;
@class Tileset;

@interface MapView : UIView

@property (nonatomic, assign) NHMapWindow *map;
@property (nonatomic, assign) Tileset *tileset;
@property (nonatomic, assign) id<NHInputHandler> inputHandler;

/** The tile rect where the player is, in local view coordinates.
 * Will return the map center if there's currently no player position.
 */
@property (nonatomic, readonly) CGRect playerRect;

@end
