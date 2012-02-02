//
//  TextMenuViewController.h
//  NetHack
//
//  Created by Dirk Zimmermann on 2/2/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextMenuViewController;

@protocol TextMenuViewControllerDelegate <NSObject>

- (void)textMenuViewControllerDone:(TextMenuViewController *)vc;

@end

@class NHMenuWindow;

@interface TextMenuViewController : UIViewController

@property (nonatomic, assign) NHMenuWindow *menuWindow;
@property (nonatomic, assign) id<TextMenuViewControllerDelegate> delegate;

@end
