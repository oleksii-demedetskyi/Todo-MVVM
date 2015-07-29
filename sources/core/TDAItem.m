//
//  TDAItem.m
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import "TDAItem.h"

@interface TDAItem ()

@property NSString* title;
@property NSDate* dueDate;
@property TDAItemStatus* status;

@end

@implementation TDAItem

+ (instancetype)newWithTitile:(NSString *)title dueDate:(NSDate *)date
{
    return [[self alloc] initWithTitle:title dueDate:date];
}

- (instancetype)initWithTitle:(NSString *)title dueDate:(NSDate *)date
{
    self = [super init];
    
    self.title = title;
    self.dueDate = date;
    self.status = [TDAItemStatus undoneStatus];
    
    return self;
}

- (void)markAsDone
{
    self.status = [TDAItemStatus doneStatus];
}

- (void)markAsUndone
{
    self.status = [TDAItemStatus undoneStatus];
}

@end

@implementation TDAItemStatus

static TDAItemStatus* doneStatus = nil;
static TDAItemStatus* undoneStatus = nil;

+ (instancetype)doneStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        doneStatus = [TDAItemStatus alloc];
    });
    
    return doneStatus;
}

+ (instancetype)undoneStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        undoneStatus = [TDAItemStatus alloc];
    });
    
    return undoneStatus;
}

- (BOOL)isDone
{
    return self == doneStatus;
}

- (BOOL)isUndone
{
    return self == undoneStatus;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


@end
