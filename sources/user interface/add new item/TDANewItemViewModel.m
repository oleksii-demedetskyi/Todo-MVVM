//
//  TDANewItemViewModel.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 30.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDANewItemViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "TDADateRangeDetector.h"
#import "TDADateFormatter.h"
#import "TDADateRangeFormatter.h"

#import "TDAItemsList.h"

@interface TDANewItemViewModel ()

@property (nonatomic) NSDate* date;
@property (nonatomic) NSString* title;
@property (nonatomic) TDAItemsList* itemList;

@end

@implementation TDANewItemViewModel

- (instancetype)init
{
    RACSignal* dateIsValid = [RACObserve(self, date) map:^NSNumber*(NSDate* date) {
        return @(date != [date earlierDate:[NSDate date]]);
    }];
    
    RACSignal* hasTitle = [RACObserve(self, title) map:^NSNumber*(NSString* title) {
        return @(title.length > 0);
    }];
    
    RAC(self, canSave, @NO) = [[dateIsValid combineLatestWith:hasTitle] and];
    
    RACSignal* rangeOfDate = [RACObserve(self, date) map:^NSNumber*(NSDate* date) {
        return @([TDADateRangeDetector rangeOfDate:date relativeToDate:[NSDate date]]);
    }];
    
    RAC(self, rangeDescription) = [rangeOfDate map:^NSString*(NSNumber* range) {
        return [TDADateRangeFormatter formatRange:range.integerValue];
    }];
    
    RAC(self, dateDescription) =
    [[rangeOfDate combineLatestWith:RACObserve(self, date)] reduceEach:^id(NSNumber* range, NSDate* date){
        return [TDADateFormatter formatDate:date forRange:range.integerValue];
    }];
    
    RAC(self, titleText, @"") = RACObserve(self, title);
    
    return self;
}

- (instancetype)initWithItemList:(TDAItemsList*)itemList
{
    self = [self init];
    
    self.date = [NSDate date];
    self.title = @"";
    self.itemList = itemList;
    
    return self;
}

+ (instancetype)newWithItemList:(TDAItemsList *)itemList
{
    return [[self alloc] initWithItemList:itemList];
}


- (void)save
{
    [self.itemList addItemWithTitle:self.title dueDate:self.date];
}

- (void)cancel
{
    self.title = nil;
    self.date = nil;
}

- (void)updateDate:(NSDate *)date
{
    self.date = date;
}

- (void)updateTitle:(NSString *)title
{
    self.title = title;
}

@end
