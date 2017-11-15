//
//  RINItemsViewController.m
//  Homepwner
//
//  Created by Zhong,Yuan on 2017/10/23.
//  Copyright © 2017年 ZhongYuan. All rights reserved.
//

#import "RINItemsViewController.h"
#import "RINItemStore.h"
#import "RINDetailViewController.h"

@implementation RINItemsViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    UINavigationItem* naviItem = self.navigationItem;
    naviItem.title = @"Homepwner";
//    naviItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
//    naviItem.backBarButtonItem.title = @"Homepwner";
    naviItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(addNewItem:)];
    
    naviItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditingMode:)];
    //naviItem.leftBarButtonItem = self.editButtonItem;
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self init];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[RINItemStore sharedStore] allItems];
    if (indexPath.row < items.count) {
        cell.textLabel.text = [items[indexPath.row] description];
    }
    else {
        cell.textLabel.text = @"No more item!";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = [[RINItemStore sharedStore] allItems];
    return [items count] + 1;
}

- (IBAction)addNewItem:(id)sender
{
    NSLog(@"addNewItem Clicked");
    RINItem *item = [[RINItemStore sharedStore] createItem];
    NSArray *items = [RINItemStore sharedStore].allItems;
    NSInteger index = [items indexOfObjectIdenticalTo:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)toggleEditingMode:(id)sender
{
    NSLog(@"toggleEditingMode Clicked");
    if (self.isEditing) {
        [sender setTitle:@"编辑"];
        [self setEditing:NO animated:YES];
    }
    else {
        [sender setTitle:@"完成"];
        [self setEditing:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger index = indexPath.row;
        if ([[RINItemStore sharedStore] removeItem:index]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[RINItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.row;
    if (index >= [[RINItemStore sharedStore] allItems].count) {
        return NO;
    }
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.row;
    if (index >= [[RINItemStore sharedStore] allItems].count) {
        return NO;
    }
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSUInteger count = [[RINItemStore sharedStore] allItems].count;
    if (proposedDestinationIndexPath.row < count) {
        return proposedDestinationIndexPath;
    }
    return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row - 1 inSection:proposedDestinationIndexPath.section];
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger count = [[RINItemStore sharedStore] allItems].count;
    if (indexPath.row >= count) {
        return nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RINDetailViewController *detailViewController = [[RINDetailViewController alloc] init];
    RINItem *item = [RINItemStore sharedStore].allItems[indexPath.row];
    detailViewController.item = item;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
