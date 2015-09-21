//
//  DatePickerViewController.m
//  Pickers
//
//  Created by devil on 15/9/13.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDate *now = [NSDate date];
    [self.datePicker setDate:now animated:NO];
    //中文格式显示
    [self.datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //北京时间
    self.datePicker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
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
- (IBAction)buttonPressed:(id)sender {
    NSDate *selected = [self.datePicker date];
    //定制日期时间显示格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //获取系统时区
//    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
//    dateFormatter.timeZone = sourceTimeZone;
    
    NSString *message = [[NSString alloc] initWithFormat:@"你选择的日期和时间为：%@",[dateFormatter stringFromDate:selected]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"选择的日期时间" message:message delegate:nil cancelButtonTitle:@"那是正确的日期和时间" otherButtonTitles:nil];
    [alert show];
}

@end
