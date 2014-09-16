//
//  CSKToDoItem.m
//  ToDoList
//
//  Created by Ceslovas Lopan on 08/09/14.
//  Copyright (c) 2014 Ceslovas Lopan. All rights reserved.
//

#import "CSKToDoItem.h"
@interface CSKToDoItem()

@property NSDate *completionDate;

@end

@implementation CSKToDoItem

// designated initializer
-(instancetype) init {
    self = [super init];
    
    if(self) {
        _creationDate = [NSDate date];
    }
    
    return self;
}

-(void) markAsCompleted:(BOOL)isCompleted {
    self.completed = isCompleted;
    [self setCompletionDate];
}

-(void)setCompletionDate {
    if(self.completed) {
        self.completionDate = [NSDate date];
    } else {
        self.completionDate = nil;
    }
}

@end
