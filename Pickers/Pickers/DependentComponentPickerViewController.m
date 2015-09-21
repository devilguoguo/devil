//
//  DependentComponentPickerViewController.m
//  Pickers
//
//  Created by devil on 15/9/13.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import "DependentComponentPickerViewController.h"
//定义滚轮下标常量
#define kStateComponent 0
#define kZipComponent 1

@interface DependentComponentPickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *dependentPicker;
//字典通过键值对进行各州邮编数组的存储
@property (strong, nonatomic) NSDictionary *stateZips;
@property (strong, nonatomic) NSArray *states;
@property (strong, nonatomic) NSArray *zips;

@end

@implementation DependentComponentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //应用程序包
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"statedictionary" withExtension:@"plist"];
    self.stateZips = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    //对所有州进行排序
    NSArray *allStates = [self.stateZips allKeys];
    NSArray *sortedStates = [allStates sortedArrayUsingSelector:@selector(compare:)];
    self.states = sortedStates;
    //默认取第一个州的邮编数组
    NSString *selectedState = self.states[0];
    self.zips = self.stateZips[selectedState];
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

//按钮事件处理
- (IBAction)buttonPressed:(id)sender {
    //当前选择的行
    NSInteger stateRow = [self.dependentPicker selectedRowInComponent:kStateComponent];
    NSInteger zipRow = [self.dependentPicker selectedRowInComponent:kZipComponent];
    //当前各滚轮选中的内容
    NSString *state = self.states[stateRow];
    NSString *zip = self.zips[zipRow];
    //要显示的提示信息
    NSString *title = [[NSString alloc] initWithFormat:@"你所选中的邮政编码是：%@",zip];
    NSString *message = [[NSString alloc] initWithFormat:@"%@ 是在 %@州的。",zip,state];
    //警告视图
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark Picker Data Source Methods
//选取器的数据源协议方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;   //双滚轮
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == kStateComponent) {
        return [self.states count]; //州的行数
    } else {
        return [self.zips count];   //邮编的行数
    }
}

#pragma mark Picker Delegate Methods
//选取器的委托协议方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == kStateComponent) {
        return self.states[row];    //对应行的州名
    } else {
        return self.zips[row];  //对应行的邮编
    }
}
//依赖性的数据选择处理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == kStateComponent) {
        NSString *seletedState = self.states[row];
        self.zips = self.stateZips[seletedState];
        [self.dependentPicker reloadComponent:kZipComponent];
        [self.dependentPicker selectRow:0 inComponent:kZipComponent animated:YES];
    }
}
//选取器显示的优化 滚轮尺寸调整
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == kStateComponent) {
        return 90;
    } else {
        return 200;
    }
}

@end
