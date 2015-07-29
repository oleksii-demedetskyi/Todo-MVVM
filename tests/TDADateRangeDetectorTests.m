//
//  TDADateRangeDetectorTests.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 29.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

@import Foundation;
#import <XCTest/XCTest.h>

#import "TDADateRangeDetector.h"

@interface TDADateRangeDetectorTests : XCTestCase

@property NSCalendar* calendar;
@property NSDate* currentDate;

@end

@implementation TDADateRangeDetectorTests

- (void)setUp
{
    [super setUp];

    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    self.calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* dateComponents = [NSDateComponents new]; {
        dateComponents.year = 2015;
        dateComponents.weekOfYear = 15;
        dateComponents.weekday = 2;
        dateComponents.hour = 12;
    }
    
    self.currentDate = [self.calendar dateFromComponents:dateComponents];
}

- (void)tearDown {
    self.calendar = nil;
    self.currentDate = nil;
    
    [super tearDown];
}

- (TDADateRangeDetectorResult)resultFromAddingValue:(NSInteger)value toUnit:(NSCalendarUnit)unit
{
    NSDate* taskDate = [self.calendar dateByAddingUnit:unit value:value toDate:self.currentDate options:0];
    return [TDADateRangeDetector rangeOfDate:taskDate relativeToDate:self.currentDate];
}

- (void)testTodayCase
{
    XCTAssertEqual([self resultFromAddingValue:3 toUnit:NSCalendarUnitHour], TDADateRangeDetectorToday);
    XCTAssertEqual([self resultFromAddingValue:-3 toUnit:NSCalendarUnitHour], TDADateRangeDetectorToday);
}

- (void)testPast
{
    XCTAssertEqual([self resultFromAddingValue:-15 toUnit:NSCalendarUnitHour], TDADateRangeDetectorPast);
    XCTAssertEqual([self resultFromAddingValue:-15 toUnit:NSCalendarUnitDay], TDADateRangeDetectorPast);
    XCTAssertEqual([self resultFromAddingValue:-15 toUnit:NSCalendarUnitMonth], TDADateRangeDetectorPast);
}

- (void)testTomorrow
{
    XCTAssertEqual([self resultFromAddingValue:15 toUnit:NSCalendarUnitHour], TDADateRangeDetectorTomorrow);
    XCTAssertEqual([self resultFromAddingValue:24 toUnit:NSCalendarUnitHour], TDADateRangeDetectorTomorrow);
    XCTAssertEqual([self resultFromAddingValue:35 toUnit:NSCalendarUnitHour], TDADateRangeDetectorTomorrow);
}

- (void)testThisWeek
{
    XCTAssertEqual([self resultFromAddingValue:37 toUnit:NSCalendarUnitHour], TDADateRangeDetectorThisWeek);
    XCTAssertEqual([self resultFromAddingValue:2 toUnit:NSCalendarUnitDay], TDADateRangeDetectorThisWeek);
    XCTAssertEqual([self resultFromAddingValue:5 toUnit:NSCalendarUnitDay], TDADateRangeDetectorThisWeek);
}

@end
