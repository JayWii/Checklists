//
//  ViewController.m
//  Checklists
//
//  Created by Cooper on 15/9/26.
//  Copyright (c) 2015年 Jason_NJUPT. All rights reserved.
//

#import "ViewController.h"
#import "ChecklistItem.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSMutableArray *_items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _items = [[NSMutableArray alloc]initWithCapacity:20];

    ChecklistItem *item;

    item = [[ChecklistItem alloc]init];
    item.text = @"看海贼王";
    item.checked = NO;
    [_items addObject:item];

    item = [[ChecklistItem alloc]init];
    item.text = @"逛Bilibili";
    item.checked = NO;
    [_items addObject:item];

    item = [[ChecklistItem alloc]init];
    item.text = @"给女朋友打电话";
    item.checked = NO;
    [_items addObject:item];

    item = [[ChecklistItem alloc]init];
    item.text = @"睡觉";
    item.checked = NO;
    [_items addObject:item];

    item = [[ChecklistItem alloc]init];
    item.text = @"看书";
    item.checked = NO;
    [_items addObject:item];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (void)configureCheckmarkForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem*)item{
    UILabel *label = (UILabel*)[cell viewWithTag:2048];
    if (item.checked) {
        label.text = @"√";
    }else{
        label.text = @"";
    }
}

- (void)configureTextForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem*)item{
    UILabel *label = (UILabel*)[cell viewWithTag:1024];
    label.text = item.text;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];

    ChecklistItem *item = _items[indexPath.row];

    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ChecklistItem *item = _items[indexPath.row];
    [item toggleChecked];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//滑动删除cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_items removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(ChecklistItem *)item{
    NSInteger newRowIndex = [_items count];
    
    [_items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;

        AddItemViewController *controller = (AddItemViewController*) navigationController.topViewController;

        controller.delegate = self;
    }
}

@end
