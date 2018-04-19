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
#include "CameraParameter.h"

using namespace std;

@interface CameraViewController () {
    SettingView *_settingView;
    FilterSetList *_settingList;
    map<string, string> _settingMap;
}

@end

@implementation CameraViewController

- (instancetype)initWithHandler:(CVHandler *)handler {
    self.title =  [NSString stringWithUTF8String:handler->get_name()];
    _settingMap.clear();
    if ( [self.title isEqualToString:@"Sobel Detection"] ) {
        _settingMap.insert(pair<string, string>("dx","1"));
        _settingMap.insert(pair<string, string>("dy","1"));
        _settingMap.insert(pair<string, string>("ksize","3"));
        handler->set_setting(_settingMap);
        _settingView = [[SettingView alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width-100, 400) Style:FilterStyle1];
    }
    else if ( [self.title isEqualToString:@"Canny Detection"] ) {
        _settingMap.insert(pair<string, string>("threshold_1","40"));
        _settingMap.insert(pair<string, string>("threshold_2","60"));
        _settingMap.insert(pair<string, string>("aperture_size","3"));
        _settingMap.insert(pair<string, string>("gradient_l2","1"));
        handler->set_setting(_settingMap);
        _settingView = [[SettingView alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width-100, 400) Style:FilterStyle2];
    }
    else {
        _settingView = [[SettingView alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width-100, 400) Style:None];
    }
    
    self = [super initWithHandler:handler];
    if ( _settingView != nil ) {
        [_settingView setHidden:YES];
        [self.view addSubview:_settingView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    UIBarButtonItem *settinfItem = [[UIBarButtonItem alloc] initWithTitle:@"Setting" style:UIBarButtonItemStylePlain target:self action:@selector(handleSetting:)];
    self.navigationItem.rightBarButtonItem = settinfItem;
    [self addKVO];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self removeKVO];
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

- (IBAction)handleSetting:(id)sender {
    if ( _settingView != nil )
        _settingView.hidden = !_settingView.hidden;
}
#pragma mark- Key-Value-Observer
- (void)addKVO {
    if ( _settingView == nil )
        return;
    
    [_settingView addObserver:self forKeyPath:@"dxSlider.value" options:NSKeyValueObservingOptionNew context:nil];
    [_settingView addObserver:self forKeyPath:@"dySlider.value" options:NSKeyValueObservingOptionNew context:nil];
    [_settingView addObserver:self forKeyPath:@"ksizeSlider.value" options:NSKeyValueObservingOptionNew context:nil];
    
    [_settingView addObserver:self forKeyPath:@"threshold_1Slider.value" options:NSKeyValueObservingOptionNew context:nil];
    [_settingView addObserver:self forKeyPath:@"threshold_2Slider.value" options:NSKeyValueObservingOptionNew context:nil];
    [_settingView addObserver:self forKeyPath:@"apertureSizeSlider.value" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeKVO {
    if ( _settingView == nil )
        return;
    
    [_settingView removeObserver:self forKeyPath:@"dxSlider.value"];
    [_settingView removeObserver:self forKeyPath:@"dySlider.value"];
    [_settingView removeObserver:self forKeyPath:@"ksizeSlider.value"];
    
    [_settingView removeObserver:self forKeyPath:@"threshold_1Slider.value"];
    [_settingView removeObserver:self forKeyPath:@"threshold_2Slider.value"];
    [_settingView removeObserver:self forKeyPath:@"apertureSizeSlider.value"];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ( [keyPath isEqualToString:@"dxSlider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["dx"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    else if ( [keyPath isEqualToString:@"dySlider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["dy"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    else if ( [keyPath isEqualToString:@"ksizeSlider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["ksize"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    
    else if ( [keyPath isEqualToString:@"threshold_1Slider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["threshold_1"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    else if ( [keyPath isEqualToString:@"threshold_2Slider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["threshold_2"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    else if ( [keyPath isEqualToString:@"apertureSizeSlider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["aperture_size"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
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
