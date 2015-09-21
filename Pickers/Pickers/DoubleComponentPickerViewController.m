//
//  DoubleComponentPickerViewController.m
//  Pickers
//
//  Created by devil on 15/9/13.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import "DoubleComponentPickerViewController.h"
//滚轮代号常量
#define kFillingComponent 0
#define kBreadComponent 1

@interface DoubleComponentPickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *doublePicker;
//属性变量 存储滚轮数据
@property (strong, nonatomic) NSArray *fillingTypes;
@property (strong, nonatomic) NSArray *breadTypes;

@end

@implementation DoubleComponentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fillingTypes = @[@"Ham",@"Turkey",@"Peanut Butter",@"Tuna Salad",@"chicken Salad",@"Roast Beef",@"Vegemite"];
    self.breadTypes = @[@"White",@"Whole Wheat",@"Rye",@"Sourdough",@"Seven Grain"];
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
//按钮被按处理
- (IBAction)buttonPressed:(id)sender {
    NSInteger fillingRow = [self.doublePicker selectedRowInComponent:kFillingComponent];
    NSInteger breadRow = [self.doublePicker selectedRowInComponent:kBreadComponent];
    
    NSString *filling = self.fillingTypes[fillingRow];
    NSString *bread = self.breadTypes[breadRow];
    NSString *message = [[NSString alloc] initWithFormat:@"Your %@ on %@ bread will be right up",filling,bread];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you for your order" message:message delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark Picker Data Source Methods
//双滚轮设定
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
//配置选取器的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == kBreadComponent) {
        return [self.breadTypes count];
    } else {
        return [self.fillingTypes count];
    }
}

#pragma mark Picker Delegate Methods
//配置选中行对应的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == kBreadComponent) {
        return self.breadTypes[row];
    } else {
        return self.fillingTypes[row];
    }
}

@end
