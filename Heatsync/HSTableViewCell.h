//
//  HSTableViewCell.h
//  Heatsync
//
//  Created by Justin Uang on 7/10/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HSTableViewCell : UITableViewCell {
    IBOutlet UILabel *name;
}

@property (nonatomic, retain) IBOutlet UILabel *name;

@end
