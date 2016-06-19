//
//  ZYCPictureTableViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/26.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCPictureTableViewController.h"

@interface ZYCPictureTableViewController ()

@end

@implementation ZYCPictureTableViewController

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(ZYCNavMaxY + ZYCTitlesViewH, 0, ZYCTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static UIColor *bgColor = nil;
    if (!bgColor) {
        bgColor = ZYCRandomColor;
    }
    static NSString * const ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = bgColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",[self class], indexPath.row];
    return cell;
}
 */

- (ZYCTopicType)type
{
    return ZYCTopicTypePicture;
}
@end
