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

#include "TDAItemsList.h"

@interface TDAItemsListViewModel ()

@property (nonatomic, strong) TDAItemsList* itemsList;

@end

@implementation TDAItemsListViewModel

+ (instancetype)newWithItemsList:(TDAItemsList*)itemsList;
{
    return [self newWithState:^(TDAItemsListViewModel* self) {
        self.itemsList = itemsList;
        // TODO: Map items signal to list of groups
    }];
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    return [TDAItemsListViewModel testViewModel];
}

+ (instancetype)testViewModel
{
    TDAItemsList* list = [TDAItemsList new];
    
    [list addItemWithTitle:@"Buy a milk" dueDate:nil];
    [list addItemWithTitle:@"Send a very important mail to customer" dueDate:nil];
    [list addItemWithTitle:@"Check this first" dueDate:nil];
    
    [list addItemWithTitle:@"Write an Osmoms lib" dueDate:nil];
    [list addItemWithTitle:@"Complete Witcher quest" dueDate:nil];
    
    return [TDAItemsListViewModel newWithItemsList:list];
}

@end

@implementation TDAItemsListGroupViewModel
@end


#import "TDAItem.h"

@interface TDAItemsListItemViewModel ()

@property (nonatomic, strong) TDAItem* item;

@end

@implementation TDAItemsListItemViewModel

+ (instancetype)newWithItem:(TDAItem*)item;
{
    return [self newWithState:^(TDAItemsListItemViewModel* self) {
        self.item = item;
    }];
}

- (void)select
{
    if (self.isChecked) {
        [self.item markAsUndone];
    } else {
        [self.item markAsDone];
    }
}

+ (NSSet *)keyPathsForValuesAffectingIsChecked
{
    return [NSSet setWithObject:@"item.status"];
}

- (BOOL)isChecked
{
    return self.item.status.isDone;
}

+ (NSSet *)keyPathsForValuesAffectingTitle
{
    return [NSSet setWithObject:@"item.title"];
}

- (NSString *)title
{
    return self.item.title;
}

+ (NSSet *)keyPathsForValuesAffectingDueTitle
{
    return [NSSet setWithObject:@"item.dueDate"];
}

- (NSString *)dueTitle
{
    // TODO: Add formatter
    return @"date";
}

@end
