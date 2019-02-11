//
//  CameraViewController.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/30.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "CameraViewController.h"

#include <opencv2/opencv.hpp>
//#include <opencv2/imgcodecs/ios.h>


using namespace std;

@interface CameraViewController ()

@end

@implementation CameraViewController

- (instancetype)initWithProcessor:(VisualBasedProcessor *)processor {
    if ( !self )
        self = [self init];
    
    if ( !processor_ )
        processor_ = processor;
    
    self.title = [processor_ getName];
    
    return self;
}

#pragma mark- View Lifecycle
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

#pragma mark- Visual Process Methods
- (void)visualProcess:(const cv::Mat &)src dst:(cv::Mat &)dst {
    if ( !processor_ )
        return;
    
    [processor_ process:src dst:dst];
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
