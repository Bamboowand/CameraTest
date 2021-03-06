
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller for camera interface
 */


#import <UIKit/UIKit.h>
#import "RosyWriterCapturePipeline.h"

#include "../CVHandlers/CVHandler.hpp"
#include "../CVHandlers/SobelHandler.hpp"
#include "../CVHandlers/CameraCalibrationHandler.hpp"
#include "../CVHandlers/GaussianBlurHandler.hpp"
#include "../CVHandlers/ThresholdHanlder.hpp"
#include "../CVHandlers/CannyHandler.hpp"

@interface RosyWriterViewController : UIViewController {
    BOOL _recording;
}

- (instancetype)initWithHandler:(CVHandler *)handler;
- (IBAction)toggleRecording:(UIButton *)sender;
- (IBAction)takePicture:(UIButton *)sender;
@end
