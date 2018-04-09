
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The RosyWriter OpenCV based effect renderer
 */

#import "RosyWriterRenderer.h"

#include "../CVHandlers/CVHandler.hpp"
#include "../CVHandlers/SobelHandler.hpp"
#include "../CVHandlers/CameraCalibrationHandler.hpp"

// To use the RosyWriterOpenCVRenderer, import this header in RosyWriterCapturePipeline.m
// and intialize _renderer to a RosyWriterOpenCVRenderer.

@interface RosyWriterOpenCVRenderer : NSObject <RosyWriterRenderer> {
    CVHandler *_handler;
}
- (instancetype)initWithHandler:(CVHandler *)handler;


@end
