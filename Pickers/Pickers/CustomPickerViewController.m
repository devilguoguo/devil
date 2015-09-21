//
//  CustomPickerViewController.m
//  Pickers
//
//  Created by devil on 15/9/13.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import "CustomPickerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CustomPickerViewController ()
//输出接口
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *winLable;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (strong, nonatomic) NSArray *images;

@end

@implementation CustomPickerViewController {
    SystemSoundID winSoundID;
    SystemSoundID crunchSoundID;
}

//显示按钮
- (void)showButton {
    self.button.hidden = NO;
}

//播放中奖的音效
- (void)playWinSound {
    if (winSoundID == 0) {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"win" withExtension:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&winSoundID);
    }
    AudioServicesPlaySystemSound(winSoundID);
    self.winLable.text = @"WINNING!";
    [self performSelector:@selector(showButton) withObject:nil afterDelay:1.5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.images = @[[UIImage imageNamed:@"seven"],
                    [UIImage imageNamed:@"bar"],
                    [UIImage imageNamed:@"crown"],
                    [UIImage imageNamed:@"cherry"],
                    [UIImage imageNamed:@"lemon"],
                    [UIImage imageNamed:@"apple"]];
    //提供一个随机数生成器
    srandom((unsigned int)time(NULL));
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

//按钮事件处理 旋转抽奖过程流程
- (IBAction)spin:(id)sender {
    BOOL win = NO;
    int numInRow = 1;
    int lastVal = -1;
    for (int i = 0; i < 5; i++) {
        int newValue = (int)(random() % [self.images count]);
        if (newValue == lastVal) {
            numInRow++;
        } else {
            numInRow = 1;
        }
        lastVal = newValue;
        
        [self.picker selectRow:newValue inComponent:i animated:YES];
        [self.picker reloadComponent:i];
        if (numInRow >= 3) {
            win = YES;
        }
    }
    if (crunchSoundID == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
        NSURL *soundURL = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&crunchSoundID);
    }
    AudioServicesPlaySystemSound(crunchSoundID);
    if (win) {
        [self performSelector:@selector(playWinSound) withObject:nil afterDelay:.5];
    } else {
        [self performSelector:@selector(showButton) withObject:nil afterDelay:.5];
    }
    self.button.hidden = YES;
    self.winLable.text = @"";
}

#pragma mark -
#pragma mark Picker Data Source Methods
//选取器数据源协议方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;   //5个滚轮
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.images count]; //每个滚轮的数据行数
}

#pragma mark Picker Delegate Methods
//选取器委托协议方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIImage *image = self.images[row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    return imageView;
}

@end
