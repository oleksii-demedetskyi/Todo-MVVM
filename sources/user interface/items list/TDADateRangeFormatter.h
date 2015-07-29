//
//  TDADateRangeFormatter.h
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 30.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TDADateRangeDetector.h"
@interface TDADateRangeFormatter : NSObject

+ (NSString*)formatRange:(TDADateRangeDetectorResult)range;

@end
