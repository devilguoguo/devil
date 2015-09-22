//
//  ToDoItem.h
//  ToDoList
//
//  Created by devil on 15/8/14.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
