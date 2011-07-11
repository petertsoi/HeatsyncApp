//
//  PlaceDetailViewController.h
//  Heatsync
//
//  Created by Justin Uang on 6/26/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlaceDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
}

@end
