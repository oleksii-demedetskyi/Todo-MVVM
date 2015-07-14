//
//  TDAItemsListViewController.h
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDAItemsListViewModel;
@interface TDAItemsListViewController : UITableViewController

@property (nonatomic, strong) IBOutlet TDAItemsListViewModel* viewModel;

@end
