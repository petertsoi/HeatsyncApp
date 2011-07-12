//
//  UIImage+NSCoding.m
//  Heatsync
//
//  Created by Justin Uang on 7/10/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "UIImage+NSCoding.h"


@implementation UIImage (NSCoding)

- (id)initWithCoder:(NSCoder *)decoder {
    NSData *pngData = [decoder decodeObjectForKey:@"PNGRepresentation"];
    [self autorelease];
    self = [[UIImage alloc] initWithData:pngData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:UIImagePNGRepresentation(self) forKey:@"PNGRepresentation"];
}

@end