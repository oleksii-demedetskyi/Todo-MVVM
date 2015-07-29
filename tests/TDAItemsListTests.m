//
//  TDAItemsListTests.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TDAItemsList.h"
#import "TDAItem.h"

@interface TDAItemsListTests : XCTestCase

@end

@implementation TDAItemsListTests

- (void)testEmptyList
{
    TDAItemsList* list = [TDAItemsList new];
    
    XCTAssertEqual(list.items.count, 0);
}

- (void)testAddingItem
{
    TDAItemsList* list = [TDAItemsList new];
    [list addItemWithTitle:@"" dueDate:nil];
    
    XCTAssertEqual(list.items.count, 1);
}

- (void)testAddedItem
{
    TDAItemsList* list = [TDAItemsList new];
    [list addItemWithTitle:@"test" dueDate:nil];
    
    TDAItem* item = list.items[0];
    XCTAssertEqualObjects(item.title, @"test");
    XCTAssertTrue(item.status.isUndone);
}

- (void)testAddingOrded
{
    TDAItemsList* list = [TDAItemsList new];
    [list addItemWithTitle:@"first" dueDate:nil];
    [list addItemWithTitle:@"second" dueDate:nil];
    
    NSArray* titles = [list.items valueForKey:@"title"];
    NSArray* expectedTitles = @[@"first", @"second"];
    
    XCTAssertEqualObjects(titles, expectedTitles);
}

@end
