//
//  TDADateRangeDetector.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 29.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDADateRangeDetector.h"

@implementation TDADateRangeDetector

+ (TDADateRangeDetectorResult)rangeOfDate:(NSDate *)taskDate relativeToDate:(NSDate *)currentDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDate* startOfToday = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:currentDate options:0];
    NSDate* startOfTommorow = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startOfToday options:0];
    NSDate* endOfTommorow = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startOfTommorow options:0];
    
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:startOfToday];
    NSDate* startOfThisWeek = [calendar dateByAddingUnit:NSCalendarUnitWeekday value:(1 - weekday) toDate:startOfToday options:0];
    NSDate* startOfNextWeek = [calendar dateByAddingUnit:NSCalendarUnitWeekOfYear value:1 toDate:startOfThisWeek options:0];
    NSDate* endOfNextWeek = [calendar dateByAddingUnit:NSCalendarUnitWeekOfYear value:1 toDate:startOfNextWeek options:0];
    
    NSInteger days = [calendar component:NSCalendarUnitDay fromDate:startOfToday];
    NSDate* startOfThisMonth = [calendar dateByAddingUnit:NSCalendarUnitDay  value:(1 - days) toDate:startOfToday options:0];
    NSDate* startOfNextMonth = [calendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:startOfThisMonth options:0];
    NSDate* endOfNextMonth = [calendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:startOfNextMonth options:0];
    
    NSInteger months = [calendar component:NSCalendarUnitMonth fromDate:startOfThisMonth];
    NSDate* startOfThisYear = [calendar dateByAddingUnit:NSCalendarUnitMonth value:(1 - months) toDate:startOfThisMonth options:0];
    NSDate* startOfNextYear = [calendar dateByAddingUnit:NSCalendarUnitYear value:1 toDate:startOfThisYear options:0];
    NSDate* endOfNextYear = [calendar dateByAddingUnit:NSCalendarUnitYear value:1 toDate:startOfNextYear options:0];
    
    if ([taskDate earlierDate:startOfToday] == taskDate) return TDADateRangeDetectorPast;
    if ([taskDate earlierDate:startOfTommorow] == taskDate) return TDADateRangeDetectorToday;
    if ([taskDate earlierDate:endOfTommorow] == taskDate) return TDADateRangeDetectorTomorrow;
    if ([taskDate earlierDate:startOfNextWeek] == taskDate) return TDADateRangeDetectorThisWeek;
    if ([taskDate earlierDate:endOfNextWeek] == taskDate) return TDADateRangeDetectorNextWeek;
    if ([taskDate earlierDate:startOfNextMonth] == taskDate) return TDADateRangeDetectorThisMonth;
    if ([taskDate earlierDate:endOfNextMonth] == taskDate) return TDADateRangeDetectorNextMonth;
    if ([taskDate earlierDate:startOfNextYear] == taskDate) return TDADateRangeDetectorThisYear;
    if ([taskDate earlierDate:endOfNextYear] == taskDate) return TDADateRangeDetectorNextYear;
    
    return TDADateRangeDetectorFarFarAway;
}


@end