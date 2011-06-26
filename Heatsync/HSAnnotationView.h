//
//  HSAnnotationView.h
//  Heatsync
//
//  Created by Justin Uang on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HSAnnotationView : MKAnnotationView {
    UIImageView *cloud;
}

@property (nonatomic, assign) UIImageView *cloud;

- (void)expandCloud;

- (void)shrinkCloud;

@end
