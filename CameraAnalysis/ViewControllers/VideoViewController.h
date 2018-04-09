//
//  VideoViewController.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/22.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#include "../CVHandlers/CVHandler.hpp"
#include "../CVHandlers/SobelHandler.hpp"
#include "../CVHandlers/CameraCalibrationHandler.hpp"
#include "../CVHandlers/GaussianBlurHandler.hpp"
#include "../CVHandlers/ThresholdHanlder.hpp"
#include "../CVHandlers/CannyHandler.hpp"

@interface VideoViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic) AVCaptureSession *session;
@property(nonatomic) AVCaptureDevice *videoDevice;
@property(nonatomic) AVCaptureInput *videoDeviceInput;
@property(nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property(nonatomic) AVCaptureDeviceDiscoverySession *videoDeviceDiscoverySession;
@property(nonatomic) dispatch_queue_t sessionQueue;

@property (strong, nonatomic) IBOutlet UIImageView *videoView;


- (instancetype)initWithHandler:(CVHandler *)handler;
- (instancetype)initWithTitleName:(NSString *)name;

@end
