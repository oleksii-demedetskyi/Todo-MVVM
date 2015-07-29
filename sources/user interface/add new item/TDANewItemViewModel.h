//
//  TDANewItemViewModel.h
//  ToDo-MVVM
//
//  Created by Алексей Демедецкий on 30.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TDAItemsList;
@interface TDANewItemViewModel : NSObject

+ (instancetype)newWithItemList:(TDAItemsList*)itemList;

- (void)save;
- (void)cancel;

@property (readonly) BOOL canSave;
@property (readonly) NSString* rangeDescription;
@property (readonly) NSString* dateDescription;
@property (readonly) NSString* titleText;
@property (readonly) NSDate* date;

- (void)updateTitle:(NSString*)title;
- (void)updateDate:(NSDate*)date;

@end
