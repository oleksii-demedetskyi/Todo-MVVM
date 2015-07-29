//
//  TDADateFormatter.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 29.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDADateFormatter.h"

@implementation TDADateFormatter

+ (NSString *)formatDate:(NSDate*)date forRange:(TDADateRangeDetectorResult)range
{
    NSDictionary* formatterMap =
    @{ @(TDADateRangeDetectorPast)      : ^{ return @""; },
       @(TDADateRangeDetectorToday)     : ^{ return [TDADateFormatter formatDateForDayRange:date];   },
       @(TDADateRangeDetectorTomorrow)  : ^{ return [TDADateFormatter formatDateForDayRange:date];   },
       @(TDADateRangeDetectorThisWeek)  : ^{ return [TDADateFormatter formatDateForWeekRange:date];  },
       @(TDADateRangeDetectorNextWeek)  : ^{ return [TDADateFormatter formatDateForWeekRange:date];  },
       @(TDADateRangeDetectorThisMonth) : ^{ return [TDADateFormatter formatDateForMonthRange:date]; },
       @(TDADateRangeDetectorNextMonth) : ^{ return [TDADateFormatter formatDateForMonthRange:date]; },
       @(TDADateRangeDetectorThisYear)  : ^{ return [TDADateFormatter formatDateForYearRange:date];  },
       @(TDADateRangeDetectorNextYear)  : ^{ return [TDADateFormatter formatDateForYearRange:date];  },
       @(TDADateRangeDetectorFarFarAway): ^{ return @""; }, };
    
    NSString*(^formatter)() = formatterMap[@(range)];
    NSAssert(formatter != nil, @"Unknown range");
    
    return formatter();
}

+ (NSString *)formatDateForDayRange:(NSDate *)date
{
    static NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateStyle = NSDateFormatterNoStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
    });
    
    return [formatter stringFromDate:date];
}

+ (NSString *)formatDateForWeekRange:(NSDate *)date
{
    static NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"EEEE";
    });
    
    return [formatter stringFromDate:date];
}

+ (NSString *)formatDateForMonthRange:(NSDate *)date
{
    static NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"d";
    });
    
    return [formatter stringFromDate:date];
}

+ (NSString *)formatDateForYearRange:(NSDate *)date
{
    static NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"MMMM d";
    });
    
    return [formatter stringFromDate:date];
}

@end
