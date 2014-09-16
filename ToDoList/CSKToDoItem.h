//
//  CSKToDoItem.h
//  ToDoList
//
//  Created by Ceslovas Lopan on 08/09/14.
//  Copyright (c) 2014 Ceslovas Lopan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSKToDoItem : NSObject
@property NSString *itemName;
@property BOOL completed;
@property NSDate *creationDate;

- (void) markAsCompleted:(BOOL) isCompleted;
@end
