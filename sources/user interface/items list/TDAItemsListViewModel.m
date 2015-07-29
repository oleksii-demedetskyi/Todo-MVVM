//
//  TDAItemsListViewModel.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 14.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//


#import "TDAItemsListViewModel.h"

#import "TDADateRangeDetector.h"
#import "TDADateRangeFormatter.h"
#import "TDADateFormatter.h"

#import "TDANewItemViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#include "TDAItemsList.h"
#include "TDAItem.h"


@interface TDAItemsListViewModel()

@property (nonatomic) NSArray* itemGroups;

@end

@interface TDAItemsListGroupViewModel()

@property (nonatomic) NSString* title;
@property (nonatomic) NSArray* items;

@end

@interface TDAItemsListItemViewModel ()

@property (nonatomic, strong) NSString* dueTitle;
@property (nonatomic, strong) TDAItem* item;

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

@interface TDAItemsListViewModel ()

@property (nonatomic, strong) TDAItemsList* itemsList;

@end

@implementation TDAItemsListViewModel

+ (instancetype)newWithItemsList:(TDAItemsList*)itemsList;
{
    return [self newWithState:^(TDAItemsListViewModel* self) {
        self.itemsList = itemsList;
        [self rac_liftSelector:@selector(updateGroupsFromItems:) withSignals:RACObserve(self, itemsList.items).logAll, nil];
    }];
}

- (void)updateGroupsFromItems:(NSArray*)itemsList
{
    NSDictionary* itemGroupMap =
    @{ @(TDADateRangeDetectorPast)      : [NSMutableArray array],
       @(TDADateRangeDetectorToday)     : [NSMutableArray array],
       @(TDADateRangeDetectorTomorrow)  : [NSMutableArray array],
       @(TDADateRangeDetectorThisWeek)  : [NSMutableArray array],
       @(TDADateRangeDetectorNextWeek)  : [NSMutableArray array],
       @(TDADateRangeDetectorThisMonth) : [NSMutableArray array],
       @(TDADateRangeDetectorNextMonth) : [NSMutableArray array],
       @(TDADateRangeDetectorThisYear)  : [NSMutableArray array],
       @(TDADateRangeDetectorNextYear)  : [NSMutableArray array],
       @(TDADateRangeDetectorFarFarAway): [NSMutableArray array], };
    
    // Move items to groups
    for (TDAItem* item in itemsList) {
        TDADateRangeDetectorResult range = [TDADateRangeDetector rangeOfDate:item.dueDate relativeToDate:[NSDate date]];
        NSMutableArray* itemGroup = itemGroupMap[@(range)];
        
        [itemGroup addObject:item];
    }
    
    
    NSMutableArray* groups = [NSMutableArray new];
    void(^appendGroupForResult)(TDADateRangeDetectorResult) = ^(TDADateRangeDetectorResult range) {
        NSArray* items = [itemGroupMap[@(range)] copy];
        if (items.count == 0) return;
        
        TDAItemsListGroupViewModel* groupViewModel = [TDAItemsListGroupViewModel new];
        groupViewModel.title = [TDADateRangeFormatter formatRange:range];
        groupViewModel.items = [items.rac_sequence map:^TDAItemsListItemViewModel*(TDAItem* item) {
            
            TDAItemsListItemViewModel* itemViewModel = [TDAItemsListItemViewModel new];
            itemViewModel.item = item;
            itemViewModel.dueTitle = [TDADateFormatter formatDate:item.dueDate forRange:range];
            return itemViewModel;
            
        }].array;
        
        [groups addObject:groupViewModel];
    };
    
    appendGroupForResult(TDADateRangeDetectorPast);
    appendGroupForResult(TDADateRangeDetectorToday);
    appendGroupForResult(TDADateRangeDetectorTomorrow);
    appendGroupForResult(TDADateRangeDetectorThisWeek);
    appendGroupForResult(TDADateRangeDetectorNextWeek);
    appendGroupForResult(TDADateRangeDetectorThisMonth);
    appendGroupForResult(TDADateRangeDetectorNextMonth);
    appendGroupForResult(TDADateRangeDetectorThisYear);
    appendGroupForResult(TDADateRangeDetectorNextYear);
    appendGroupForResult(TDADateRangeDetectorFarFarAway);
    
    self.itemGroups = groups.copy;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    return [TDAItemsListViewModel testViewModel];
}

+ (instancetype)testViewModel
{
    TDAItemsList* list = [TDAItemsList new];
    
    [list addItemWithTitle:@"Buy a milk" dueDate:[NSDate date]];
    [list addItemWithTitle:@"Send a very important mail to customer" dueDate:[NSDate date]];
    [list addItemWithTitle:@"Check this first" dueDate:[NSDate date]];
    
    [list addItemWithTitle:@"Write an Osmoms lib" dueDate:[NSDate date]];
    [list addItemWithTitle:@"Complete Witcher quest" dueDate:nil];
    
    return [TDAItemsListViewModel newWithItemsList:list];
}

- (TDANewItemViewModel *)viewModelForNewItem
{
    return [TDANewItemViewModel newWithItemList:self.itemsList];
}

@end

@implementation TDAItemsListGroupViewModel
@end

@implementation TDAItemsListItemViewModel

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

@end
