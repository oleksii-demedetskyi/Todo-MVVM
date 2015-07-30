//
//  TDAItemsList.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDAItemsList.h"
#import "TDAItem.h"

@interface TDAItemsList ()

@property NSArray* items;

@end

@implementation TDAItemsList

- (void)addItemWithTitle:(NSString *)title dueDate:(NSDate*)date;
{
    TDAItem* item = [TDAItem newWithTitile:title dueDate:date];
    self.items = [(self.items ?: @[]) arrayByAddingObject:item];
}

- (void)removeItem:(TDAItem *)item
{
    NSMutableArray* items = self.items.mutableCopy;
    [items removeObject:item];
    self.items = items.copy;
}

@end
