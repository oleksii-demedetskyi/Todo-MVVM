//
//  TDAItemsListViewModel.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 14.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDAItemsListViewModel.h"

@interface TDAItemsListViewModel()

@property (nonatomic) NSArray* itemGroups;

@end

@interface TDAItemsListGroupViewModel()

@property (nonatomic) NSString* title;
@property (nonatomic) NSArray* items;

@end


@interface TDAItemsListItemViewModel()

@property (nonatomic) BOOL isChecked;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* dueTitle;

@end

typedef void(^StateBlock)(id self);
@interface NSObject (newWithState)

+ (instancetype)newWithState:(StateBlock)state;

@end

@implementation NSObject (newWithState)

+ (instancetype)newWithState:(StateBlock)stateBlock
{
    id object = [self new];
    
    if (stateBlock != nil) {
        stateBlock(object);
    }
    
    return object;
}

@end

@implementation TDAItemsListViewModel

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    return [TDAItemsListViewModel testViewModel];
}

+ (instancetype)testViewModel
{
    return [TDAItemsListViewModel newWithState:^(TDAItemsListViewModel* self) {
        self.itemGroups =
        @[
          [TDAItemsListGroupViewModel newWithState:^(TDAItemsListGroupViewModel* self) {
              self.title = @"Today";
              self.items =
              @[
                [TDAItemsListItemViewModel newWithState:^(TDAItemsListItemViewModel* self) {
                    self.title = @"Buy a milk";
                    self.dueTitle = @"10:38";
                }],
                [TDAItemsListItemViewModel newWithState:^(TDAItemsListItemViewModel* self) {
                    self.title = @"Send a very important mail to customer";
                    self.dueTitle = @"11:00";
                }],
                [TDAItemsListItemViewModel newWithState:^(TDAItemsListItemViewModel* self) {
                    self.title = @"Check this first";
                    self.dueTitle = @"12:00";
                    self.isChecked = YES;
                }], ];
          }],
          [TDAItemsListGroupViewModel newWithState:^(TDAItemsListGroupViewModel* self) {
              self.title = @"This week";
              self.items =
              @[
                [TDAItemsListItemViewModel newWithState:^(TDAItemsListItemViewModel* self) {
                    self.title = @"Write an Osmoms lib";
                    self.dueTitle = @"Tomorrow";
                }],
                [TDAItemsListItemViewModel newWithState:^(TDAItemsListItemViewModel* self) {
                    self.title = @"Complete Witcher quest";
                    self.dueTitle = @"Friday";
                    self.isChecked = YES;
                }], ];
          }], ];
    }];
}

@end

@implementation TDAItemsListGroupViewModel
@end

@implementation TDAItemsListItemViewModel

- (void)select
{
    self.isChecked = !self.isChecked;
}

@end
