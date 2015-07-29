//
//  TDADateRangeDetector.h
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 29.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TDADateRangeDetectorResult) {
    TDADateRangeDetectorUndefined = 0,
    
    TDADateRangeDetectorPast,
    TDADateRangeDetectorToday,
    TDADateRangeDetectorTomorrow,
    TDADateRangeDetectorThisWeek,
    TDADateRangeDetectorNextWeek,
    TDADateRangeDetectorThisMonth,
    TDADateRangeDetectorNextMonth,
    TDADateRangeDetectorThisYear,
    TDADateRangeDetectorNextYear,
    TDADateRangeDetectorFarFarAway,
};

@interface TDADateRangeDetector : NSObject

+ (TDADateRangeDetectorResult)rangeOfDate:(NSDate*)date relativeToDate:(NSDate*)date;

@end
