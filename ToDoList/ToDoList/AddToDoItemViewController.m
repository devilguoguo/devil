//
//  AddToDoItemViewController.m
//  ToDoList
//
//  Created by devil on 15/8/13.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import "AddToDoItemViewController.h"

@interface AddToDoItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation AddToDoItemViewController

//在 segue 执行前，系统通过调用 prepareForSegue:，给所包含的视图控制器一次准备机会
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //如果未按下就不存储项目，而是让方法返回但不执行任何其他操作。
    if (sender != self.doneButton) return;
    //查看一下文本栏中是否有文本。
    if (self.textField.text.length > 0) {
        //创建一个新项目，并用文本栏中的文本为其命名，未完成状态
        self.toDoItem = [[ToDoItem alloc] init];
        self.toDoItem.itemName = self.textField.text;
        self.toDoItem.completed = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
