//
//  TDADateRangeFormatter.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 30.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDADateRangeFormatter.h"


@implementation TDADateRangeFormatter

+ (NSString*)formatRange:(TDADateRangeDetectorResult)range;
{
    NSDictionary* titleMap =
    @{ @(TDADateRangeDetectorPast)      : @"Missed",
       @(TDADateRangeDetectorToday)     : @"Today",
       @(TDADateRangeDetectorTomorrow)  : @"Tomorrow",
       @(TDADateRangeDetectorThisWeek)  : @"This week",
       @(TDADateRangeDetectorNextWeek)  : @"Next week",
       @(TDADateRangeDetectorThisMonth) : @"This month",
       @(TDADateRangeDetectorNextMonth) : @"Next month",
       @(TDADateRangeDetectorThisYear)  : @"This year",
       @(TDADateRangeDetectorNextYear)  : @"Next year",
       @(TDADateRangeDetectorFarFarAway): @"Someday" };

    return titleMap[@(range)];
}

@end
