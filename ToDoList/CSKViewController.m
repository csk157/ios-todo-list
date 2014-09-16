
//
//  CSKViewController.m
//  ToDoList
//
//  Created by Ceslovas Lopan on 08/09/14.
//  Copyright (c) 2014 Ceslovas Lopan. All rights reserved.
//

#import "CSKViewController.h"

@interface CSKViewController ()
@property (weak, nonatomic) IBOutlet UITextField *toDoItemTxt;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation CSKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toDoItemTxt.delegate = self;
}

-(BOOL) validateText {
    return self.toDoItemTxt.text.length > 0;
}

-(IBAction) returnToList:(id)sender {
    if(sender == self.doneButton || sender == self.toDoItemTxt){
        [self createItem];
    }
    [self performSegueWithIdentifier:@"unwindToList" sender:sender];
}

-(void) createItem {
    if([self validateText]) {
        self.toDoItem = [[CSKToDoItem alloc] init];
        self.toDoItem.itemName = self.toDoItemTxt.text;
        self.toDoItem.completed = NO;
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self returnToList:textField];
    return YES;
}

@end
