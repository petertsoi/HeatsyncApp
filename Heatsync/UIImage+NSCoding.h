//
//  UIImage+NSCoding.h
//  Heatsync
//
//  Created by Justin Uang on 7/10/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (NSCoding)

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
