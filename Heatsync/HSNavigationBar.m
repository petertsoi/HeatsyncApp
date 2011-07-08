//
//  HSNavigationBar.m
//  Heatsync
//
//  Created by Justin Uang on 7/7/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "HSNavigationBar.h"


@implementation HSNavigationBar

- (void) drawRect:(CGRect)rect {
    UIImage *barImage = [UIImage imageNamed:@"topbar.png"];
    [barImage drawInRect:rect];
}

@end
