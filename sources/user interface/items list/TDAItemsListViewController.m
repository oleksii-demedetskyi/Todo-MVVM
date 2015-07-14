//
//  TDAItemsListViewController.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDAItemsListViewController.h"
#import "TDAItemsListViewModel.h"

@interface TDAItemsListViewController ()

@end

@implementation TDAItemsListViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.itemGroups.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TDAItemsListGroupViewModel* group = self.viewModel.itemGroups[section];
    return group.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TDAItemsListGroupViewModel* group = self.viewModel.itemGroups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDAItemsListGroupViewModel* group = self.viewModel.itemGroups[indexPath.section];
    TDAItemsListItemViewModel* item = group.items[indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"com.itemslist.cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.dueTitle;
    cell.imageView.hidden = !item.isChecked;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDAItemsListGroupViewModel* group = self.viewModel.itemGroups[indexPath.section];
    TDAItemsListItemViewModel* item = group.items[indexPath.row];

    [item select];
}

@end
