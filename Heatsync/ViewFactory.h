//
//  ViewFactory.h
//  Heatsync
//
//  Created by Justin Uang on 7/10/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewFactory : NSObject {
    NSMutableDictionary * viewTemplateStore;
}

- (id)initWithNib:(NSString*)aNibName;

- (UITableViewCell*)cellOfKind: (NSString*)theCellKind forTable: (UITableView*)aTableView;

@end