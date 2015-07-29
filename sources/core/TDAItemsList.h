//
//  TDAItemsList.h
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 10.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDAItemsList : NSObject

@property (readonly) NSArray* items;

- (void)addItemWithTitle:(NSString *)title dueDate:(NSDate*)date;

@end
