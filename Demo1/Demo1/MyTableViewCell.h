//
//  MyTableViewCell.h
//  Demo1
//
//  Created by devil on 15/9/17.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

//用copy是因为字符串可能被修改 先备份一下
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *color;

@end
