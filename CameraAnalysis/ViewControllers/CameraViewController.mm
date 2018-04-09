//
//  CameraViewController.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/30.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "CameraViewController.h"
#import "SettingView.h"

#include <opencv2/opencv.hpp>
#include <opencv2/imgcodecs/ios.h>

#include <map>

using namespace std;

@interface CameraViewController () {
    SettingView *_settingView;
    map<string, string> _settingMap;
}

@end

@implementation CameraViewController

- (instancetype)initWithHandler:(CVHandler *)handler {
    self.title =  [NSString stringWithUTF8String:handler->get_name()];
    _settingView = [[SettingView alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width-100, 400) Style:FilterStyle1];
    _settingMap.clear();
    if ( [self.title isEqualToString:@"Sobel Detection"] ) {
        _settingMap.insert(pair<string, string>("dx","1"));
        _settingMap.insert(pair<string, string>("dy","1"));
        _settingMap.insert(pair<string, string>("ksize","3"));
        handler->set_setting(_settingMap);
    }
    else {
        
    }

    
    self = [super initWithHandler:handler];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Notification method
- (void)handleDeviceOrientationChange:(NSNotification *)notification {
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            break;
        }
        default:
        {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            break;
        }
    }
}
- (IBAction)switchDevice:(UISegmentedControl *)sender {
    if ( sender.selectedSegmentIndex == 0 ) {
        [self.actionButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    else if ( sender.selectedSegmentIndex == 1 ){
        [self.actionButton setTitle:@"Photo" forState:UIControlStateNormal];
    }
    else {
        
    }
}

- (IBAction)changeOutput:(UIButton *)sender {
    if ( self.outputSwitch.selectedSegmentIndex == 0 ) {
            if ( !_recording ) {
                [self.actionButton setTitle:@"Stop" forState:UIControlStateNormal];
            }
            else {
                [self.actionButton setTitle:@"Record" forState:UIControlStateNormal];
            }
        [super toggleRecording:sender];
    }
    else {
//        [self.actionButton setTitle:@"Photo" forState:UIControlStateNormal];
        [super takePicture:sender];
    }
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
