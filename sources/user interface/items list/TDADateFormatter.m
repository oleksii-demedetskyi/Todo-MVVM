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
    NSString*(^formatter)() =
    [switch_(range) past:^{ return @""; }
                   today:^{ return [TDADateFormatter formatDateForDayRange:date];   }
                tomorrow:^{ return [TDADateFormatter formatDateForDayRange:date];   }
                thisWeek:^{ return [TDADateFormatter formatDateForWeekRange:date];  }
                nextWeek:^{ return [TDADateFormatter formatDateForWeekRange:date];  }
               thisMonth:^{ return [TDADateFormatter formatDateForMonthRange:date]; }
               nextMonth:^{ return [TDADateFormatter formatDateForMonthRange:date]; }
                thisYear:^{ return [TDADateFormatter formatDateForYearRange:date];  }
                nextYear:^{ return [TDADateFormatter formatDateForYearRange:date];  }
                 farAway:^{ return @""; }];
    
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
