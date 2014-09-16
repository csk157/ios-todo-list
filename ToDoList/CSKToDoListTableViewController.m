//
//  CSKToDoListTableViewController.m
//  ToDoList
//
//  Created by Ceslovas Lopan on 08/09/14.
//  Copyright (c) 2014 Ceslovas Lopan. All rights reserved.
//

#import "CSKToDoListTableViewController.h"
#import "CSKToDoItem.h"
#import "CSKViewController.h"

@interface CSKToDoListTableViewController ()
@property NSMutableArray *toDoItems;
@end

@implementation CSKToDoListTableViewController

-(void)synchronizeWithPlist{
    NSString *filePath = [self getFilePath];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:filePath]) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
        
        for(NSDictionary *d in arr) {
            CSKToDoItem *item = [[CSKToDoItem alloc] init];
            item.itemName = d[@"itemName"];
            item.creationDate = d[@"creationDate"];
            item.completed = [d[@"completed"] boolValue];
            
            [self.toDoItems addObject:item];
        }
    }
}

// save todo items to plist
-(void)synchronizeWithToDoItems {
    NSString *filePath = [self getFilePath];
    NSMutableArray *data = [NSMutableArray array];

    for(CSKToDoItem *item in self.toDoItems) {
        NSDictionary *dict = @{
                               @"itemName": item.itemName,
                               @"completed": [NSNumber numberWithBool:item.completed],
                               @"creationDate": item.creationDate
                               };
        [data addObject:dict];
    }
    
    [data writeToFile:filePath atomically:YES];
}

-(NSString*)getFilePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = documentDirectories[0];
    
    NSString *filePath = [documentDirectory stringByAppendingString:@"/todoitems.plist"];
    
    return filePath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.toDoItems = [NSMutableArray array];
    [self synchronizeWithPlist];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDoItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toDoItemCell" forIndexPath:indexPath];
    
    CSKToDoItem *cellItem = self.toDoItems[indexPath.row];
    cell.textLabel.text = cellItem.itemName;
    cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:cellItem.creationDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
    
    if(cellItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CSKToDoItem *selectedItem = self.toDoItems[indexPath.row];
    selectedItem.completed = !selectedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.toDoItems removeObjectAtIndex:indexPath.row];
        [self synchronizeWithToDoItems];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}


-(IBAction)unwindToList:(UIStoryboardSegue*)segue {
    CSKViewController *source = [segue sourceViewController];
    CSKToDoItem *item = source.toDoItem;
    
    if(item != nil) {
        [self.toDoItems addObject:item];
        [self synchronizeWithToDoItems];
        [self.tableView reloadData];
    }
}

@end
