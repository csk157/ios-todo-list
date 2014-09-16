//
//  CSKViewController.h
//  ToDoList
//
//  Created by Ceslovas Lopan on 08/09/14.
//  Copyright (c) 2014 Ceslovas Lopan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSKToDoItem.h"

@interface CSKViewController : UIViewController <UITextFieldDelegate>
@property CSKToDoItem *toDoItem;
@end
