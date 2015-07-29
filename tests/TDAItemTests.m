//
//  TDAItemTests.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TDAItem.h"

@interface TDAItemTests : XCTestCase

@end

@implementation TDAItemTests

- (void)testStatusOfNewItem
{
    TDAItem* item = [TDAItem newWithTitile:@"" dueDate:nil];
    
    XCTAssertTrue(item.status.isUndone);
}

- (void)testTitleMatch
{
    TDAItem* item = [TDAItem newWithTitile:@"example" dueDate:nil];
    
    XCTAssertEqualObjects(item.title, @"example");
}

- (void)testStatusChangeToDone
{
    TDAItem* item = [TDAItem newWithTitile:@"" dueDate:nil];
    [item markAsDone];
    
    XCTAssertTrue(item.status.isDone);
}

- (void)testStatusChangeToUndone
{
    TDAItem* item = [TDAItem newWithTitile:@"" dueDate:nil];
    [item markAsDone];
    [item markAsUndone];
    
    XCTAssertTrue(item.status.isUndone);
    
}

@end


@interface TDAItemStatusTests : XCTestCase
@end

@implementation TDAItemStatusTests

- (void)testUndoneStatus
{
    TDAItemStatus* status = [TDAItemStatus undoneStatus];
    
    XCTAssertTrue(status.isUndone);
    XCTAssertFalse(status.isDone);
}

- (void)testStatus
{
    TDAItemStatus* status = [TDAItemStatus doneStatus];
    
    XCTAssertTrue(status.isDone);
    XCTAssertFalse(status.isUndone);
}

- (void)testDictionaryMatching
{
    NSDictionary* map =
    @{
      [TDAItemStatus doneStatus] : @"done",
      [TDAItemStatus undoneStatus] : @"undone",
      };
    
    TDAItemStatus* status = [TDAItemStatus doneStatus];
    NSString* resolution = [map objectForKey:status];
    
    XCTAssertEqualObjects(resolution, @"done");
}

- (void)testEquality
{
    TDAItemStatus* done = [TDAItemStatus doneStatus];
    
    XCTAssertEqual(done, [TDAItemStatus doneStatus]);
    XCTAssertNotEqual(done, [TDAItemStatus undoneStatus]);
    
    XCTAssertEqualObjects(done, [TDAItemStatus doneStatus]);
    XCTAssertNotEqualObjects(done, [TDAItemStatus undoneStatus]);
}

@end