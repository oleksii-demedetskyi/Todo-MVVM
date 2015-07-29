//
//  TDANewItemViewController.h
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 30.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

@import UIKit;

@class TDANewItemViewModel;
@interface TDANewItemViewController : UITableViewController

@property (nonatomic) TDANewItemViewModel* viewModel;

@end
