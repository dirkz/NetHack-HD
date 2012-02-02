//
//  MapView.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/2/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NHMapWindow;

@interface MapView : UIView

@property (nonatomic, retain) NHMapWindow *map;

@end
