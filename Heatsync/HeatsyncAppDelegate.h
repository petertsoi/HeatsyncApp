//
//  HeatsyncAppDelegate.h
//  Heatsync
//
//  Created by Justin Uang on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeatsyncViewController;

@interface HeatsyncAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HeatsyncViewController *viewController;

@end
