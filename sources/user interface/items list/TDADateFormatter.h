//
//  TDADateFormatter.h
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 29.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TDADateRangeDetector.h"
@interface TDADateFormatter : NSObject

+ (NSString *)formatDate:(NSDate*)date forRange:(TDADateRangeDetectorResult)range;

+ (NSString*)formatDateForDayRange:(NSDate*)date;
+ (NSString*)formatDateForWeekRange:(NSDate*)date;
+ (NSString*)formatDateForMonthRange:(NSDate*)date;
+ (NSString*)formatDateForYearRange:(NSDate*)date;

@end
