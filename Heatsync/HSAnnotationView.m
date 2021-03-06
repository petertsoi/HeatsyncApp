//
//  HSAnnotationView.m
//  Heatsync
//
//  Created by Justin Uang on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "HSAnnotationView.h"


@implementation HSAnnotationView

@synthesize cloud;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])) {
        self.userInteractionEnabled = YES;
        self.bounds = CGRectMake(0, 0, 12, 12);
        self.canShowCallout = YES;
        self.calloutOffset = CGPointMake(0, -5);
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        self.rightCalloutAccessoryView = rightButton;
        
        UIImageView *dot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smalldot.png"]];
        dot.userInteractionEnabled = YES;
        [self addSubview:dot];
        dot.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        
        self.cloud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buffercircle.png"]];
        self.cloud.center = CGPointMake(dot.center.x - 1, dot.center.y - 2);
        self.cloud.userInteractionEnabled = YES;
        
        
        [self addSubview:cloud];
        [self sendSubviewToBack:cloud];
        cloud.transform = CGAffineTransformMakeScale(0.3, 0.3);
        [self shrinkCloud];
    }
    
    return self;
}

- (void)expandCloud {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cloud.transform = CGAffineTransformMakeScale(0.3, 0.3);
    } completion:^ (BOOL test){
        [self shrinkCloud];
    }];
}

- (void)shrinkCloud {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cloud.transform = CGAffineTransformMakeScale(0.05, 0.05);
    } completion:^ (BOOL test){
        [self expandCloud];
    }];
    
}


@end
