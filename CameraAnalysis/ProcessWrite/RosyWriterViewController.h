
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller for camera interface
 */


#import <UIKit/UIKit.h>
#import "RosyWriterCapturePipeline.h"

#import "BaseFilterModel.h"
#import "SobelFilterModel.h"

#include "../CVHandlers/CVHandler.hpp"
#include "../CVHandlers/SobelHandler.hpp"
#include "../CVHandlers/CameraCalibrationHandler.hpp"
#include "../CVHandlers/GaussianBlurHandler.hpp"
#include "../CVHandlers/ThresholdHanlder.hpp"
#include "../CVHandlers/CannyHandler.hpp"

@interface RosyWriterViewController : UIViewController {
    BOOL _recording;
    CVHandler *_handler;
    BaseFilterModel *_filterModel;
}

- (instancetype)initWithHandler:(CVHandler *)handler;
- (instancetype)initWithFilterModel:(BaseFilterModel *)filterModel;
- (IBAction)toggleRecording:(UIButton *)sender;
- (IBAction)takePicture:(UIButton *)sender;
@end
