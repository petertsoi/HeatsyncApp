//
//  PlaceDetailViewController.m
//  Heatsync
//
//  Created by Justin Uang on 6/26/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "ViewFactory.h"
#import "HSTableViewCell.h"

@implementation PlaceDetailViewController

@synthesize factory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setBackgroundImage:[UIImage imageNamed:@"backbutton_up.png"] forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"backbutton_down.png"] forState:UIControlStateSelected];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        CGRect frame = frameAnchoredAtZero([[UIImage imageNamed:@"backbutton_up.png"] size]);
        [backButton setFrame:frame];
        
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [backButtonItem setTarget:self];
        [backButtonItem setAction:@selector(backButtonPressed:)];
        [[self navigationItem] setLeftBarButtonItem:backButtonItem];
        
        self.factory = [[[ViewFactory alloc] initWithNib:@"TableViewCells"] autorelease];
    }
    return self;
}

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listbar.png"]];
    UIView *headerViewWrapper = [[UIView alloc] initWithFrame:headerView.frame];
    [headerViewWrapper addSubview:headerView];
    
    return headerViewWrapper;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSTableViewCell *cell = (HSTableViewCell *) [self.factory cellOfKind:@"cell" forTable:aTableView];
    UILabel *nameLabel = (UILabel *) [cell viewWithTag:kTableCellName];
    UILabel *locationLabel = (UILabel *) [cell viewWithTag:kTableCellLocation];
    UILabel *numberLabel = (UILabel *) [cell viewWithTag:kTableCellNumber];
    nameLabel.text = @"Name";
    locationLabel.text = @"Location";
    numberLabel.text = @"22";
    
    
    return cell;
}

- (void)dealloc
{
    self.factory = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableView.rowHeight = [UIImage imageNamed:@"listitem_bg.png"].size.height;
    tableView.sectionHeaderHeight = [UIImage imageNamed:@"listbar.png"].size.height - 1;
    
    self.title = @"Info";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
