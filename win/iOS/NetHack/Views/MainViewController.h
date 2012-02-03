//
//  MainViewController.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/1/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TextMenuViewController.h"
#import "MapView.h"

@interface MainViewController : UIViewController <UITextViewDelegate,TextMenuViewControllerDelegate, MapViewDelegate>

@end
