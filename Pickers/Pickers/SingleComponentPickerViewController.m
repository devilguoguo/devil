//
//  SingleComponentPickerViewController.m
//  Pickers
//
//  Created by devil on 15/9/13.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import "SingleComponentPickerViewController.h"

@interface SingleComponentPickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *singlePicker;
@property (strong, nonatomic) NSArray *characterNames;

@end

@implementation SingleComponentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.characterNames = @[@"小黄人",@"破风",@"左耳",@"神奇四侠",@"滚蛋吧，肿瘤君",@"捉妖记",@"侏罗纪世界",@"栀子花开"];
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
//按钮触发处理
- (IBAction)buttonPressed:(id)sender {
    NSInteger row = [self.singlePicker selectedRowInComponent:0];
    NSString *selected = self.characterNames[row];
    NSString *title = [[NSString alloc] initWithFormat:@"你选择的电影是：%@",selected];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"谢谢惠顾！！！" delegate:nil cancelButtonTitle:@"不客气" otherButtonTitles:nil];
    [alert show];
}

//插入一条分隔线和一个文本条目
#pragma mark -
#pragma mark Picker Data Source Methods
//数据源协议方法
//滚轮个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//选取器的数据行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.characterNames count];
}

#pragma mark Picker Delegate Methods
//委托的协议方法 一般都是可选的
//提供指定行数的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.characterNames[row];
}


@end
