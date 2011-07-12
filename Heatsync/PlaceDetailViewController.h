//
//  PlaceDetailViewController.h
//  Heatsync
//
//  Created by Justin Uang on 6/26/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewFactory;

typedef enum {
    kTableCellName = 100,
    kTableCellLocation,
    kTableCellNumber
} TableCellProperties;

@interface PlaceDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
    
    ViewFactory *factory;
}

@property (nonatomic, retain) ViewFactory *factory;

@end
