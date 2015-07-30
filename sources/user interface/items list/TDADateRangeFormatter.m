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
    return [switch_(range) past:@"Missed"
                          today:@"Today"
                       tomorrow:@"Tomorrow"
                       thisWeek:@"This week"
                       nextWeek:@"Next week"
                      thisMonth:@"This month"
                      nextMonth:@"Next month"
                       thisYear:@"This year"
                       nextYear:@"Next year"
                        farAway:@"Someday"];
}

@end
