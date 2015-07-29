//
//  TDANewItemViewController.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 30.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDANewItemViewController.h"
#import "TDANewItemViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TDANewItemViewController ()

@property (nonatomic) IBOutlet UITextField* titleTextField;
@property (nonatomic) IBOutlet UIDatePicker* timePicker;
@property (nonatomic) IBOutlet UILabel* timeLabel;
@property (nonatomic) IBOutlet UILabel* rangeLabel;

@property (nonatomic) IBOutlet UIBarButtonItem* saveItemButton;

@end

@implementation TDANewItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RAC(self, titleTextField.text) =
    RACObserve(self, viewModel.titleText).distinctUntilChanged.deliverOnMainThread;
    
    RAC(self, timeLabel.text) =
    RACObserve(self, viewModel.dateDescription).distinctUntilChanged.deliverOnMainThread;
    
    RAC(self, rangeLabel.text) =
    RACObserve(self, viewModel.rangeDescription).distinctUntilChanged.deliverOnMainThread;
    
    RAC(self, timePicker.date) =
    [RACObserve(self, viewModel.date) ignore:nil].distinctUntilChanged.deliverOnMainThread;
    
    RAC(self, saveItemButton.enabled, @NO) =
    RACObserve(self, viewModel.canSave).distinctUntilChanged.deliverOnMainThread;
}

- (IBAction)cancel
{
    [self.view endEditing:YES];
    [self.viewModel cancel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveItem
{
    [self.view endEditing:YES];
    [self.viewModel save];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)titleDidReturn
{
    [self.titleTextField resignFirstResponder];
}

- (IBAction)didUpdateTitle
{
    [self.viewModel updateTitle:self.titleTextField.text];
}

- (IBAction)didUpdateDate
{
    [self.viewModel updateDate:self.timePicker.date];
}

@end
