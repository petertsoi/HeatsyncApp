//
//  HSTableViewCell.m
//  Heatsync
//
//  Created by Justin Uang on 7/10/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "HSTableViewCell.h"


@implementation HSTableViewCell

@synthesize name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
