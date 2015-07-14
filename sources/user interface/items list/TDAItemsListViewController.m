//
//  TDAItemsListViewController.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDAItemsListViewController.h"

@interface TDAItemsListViewController ()

@end

@implementation TDAItemsListViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"test";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"com.itemslist.cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Example Example Example";
    cell.detailTextLabel.text = @"Today";
    cell.imageView.hidden = (indexPath.row % 3 != 0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selecet at %@", indexPath);
}

@end
