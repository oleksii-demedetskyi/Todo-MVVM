//
//  TDAItemsListViewController.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDAItemsListViewController.h"
#import "TDAItemsListViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
@interface TDAItemsListViewController ()

@end

@interface TDAItemsListItemCell : UITableViewCell

@property (nonatomic, strong) TDAItemsListItemViewModel* viewModel;

@end

@implementation TDAItemsListItemCell

- (void)prepareForReuse
{
    self.viewModel = nil;
}

- (void)setupBindings
{
    RAC(self, textLabel.text) = RACObserve(self, viewModel.title);
    RAC(self, detailTextLabel.text) = RACObserve(self, viewModel.dueTitle);
    RAC(self, imageView.hidden) = [[RACObserve(self, viewModel.isChecked) ignore:nil] not];
}

- (void)awakeFromNib
{
    [self setupBindings];
    [super awakeFromNib];
}

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
    
    TDAItemsListItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"com.itemslist.cell" forIndexPath:indexPath];
    cell.viewModel = item;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDAItemsListGroupViewModel* group = self.viewModel.itemGroups[indexPath.section];
    TDAItemsListItemViewModel* item = group.items[indexPath.row];

    [item select];
}

@end
