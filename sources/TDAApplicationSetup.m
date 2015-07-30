//
//  TDAApplicationSetup.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 30.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDAApplicationSetup.h"

#import "TDAItemsList.h"
#import "TDAItemsListViewModel.h"
#import "TDAItemsListViewController.h"

@implementation TDAApplicationSetup

+ (void)setupApplicationInWindow:(UIWindow*)window
{
    UIStoryboard* storyboard =
    [UIStoryboard storyboardWithName:@"ListAndItem" bundle:[NSBundle bundleForClass:[self class]]];
    
    TDAItemsList* itemList = [TDAItemsList new];
    TDAItemsListViewModel* viewModel = [TDAItemsListViewModel newWithItemList:itemList];
    
    UINavigationController* navigationController =
    [storyboard instantiateViewControllerWithIdentifier:@"item list container"];
    
    TDAItemsListViewController* viewController = navigationController.viewControllers.firstObject;
    viewController.viewModel = viewModel;
    
    window.rootViewController = navigationController;
}

@end
