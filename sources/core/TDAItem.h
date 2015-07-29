//
//  TDAItem.h
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TDAItemStatus;
@interface TDAItem : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)newWithTitile:(NSString*)title dueDate:(NSDate*)date;

@property (readonly) TDAItemStatus* status;
@property (readonly) NSString* title;
@property (readonly) NSDate* dueDate;

- (void)markAsDone;
- (void)markAsUndone;

@end


@interface TDAItemStatus : NSObject<NSCopying>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)undoneStatus;
+ (instancetype)doneStatus;

@property (readonly) BOOL isUndone;
@property (readonly) BOOL isDone;

@end