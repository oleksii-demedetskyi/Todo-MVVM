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

@interface TDADateRangeDetectorResultSwitch : NSObject<TDADateRangeDetectorSwitch>
@property TDADateRangeDetectorResult result;
@end

@implementation TDADateRangeDetectorResultSwitch

- (id)past:(id)pastValue
     today:(id)todayValue
  tomorrow:(id)tomorrowValue
  thisWeek:(id)thisWeekValue
  nextWeek:(id)nextWeekValue
 thisMonth:(id)thisMonthValue
 nextMonth:(id)nextMonthValue
  thisYear:(id)thisYearValue
  nextYear:(id)nextYearValue
   farAway:(id)farAwayValue
{
    if (self.result == TDADateRangeDetectorPast) return pastValue;
    if (self.result == TDADateRangeDetectorToday) return todayValue;
    if (self.result == TDADateRangeDetectorTomorrow) return tomorrowValue;
    if (self.result == TDADateRangeDetectorThisWeek) return thisWeekValue;
    if (self.result == TDADateRangeDetectorNextWeek) return nextWeekValue;
    if (self.result == TDADateRangeDetectorThisMonth) return thisMonthValue;
    if (self.result == TDADateRangeDetectorNextMonth) return nextMonthValue;
    if (self.result == TDADateRangeDetectorThisYear) return thisYearValue;
    if (self.result == TDADateRangeDetectorNextYear) return nextYearValue;
    if (self.result == TDADateRangeDetectorFarFarAway) return farAwayValue;
    
    return nil;
}

@end

id<TDADateRangeDetectorSwitch> switch_(TDADateRangeDetectorResult range) {
    TDADateRangeDetectorResultSwitch* switchObject = [TDADateRangeDetectorResultSwitch new];
    switchObject.result = range;
    
    return switchObject;
}