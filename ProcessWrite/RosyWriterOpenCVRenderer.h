
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The RosyWriter OpenCV based effect renderer
 */

#import "RosyWriterRenderer.h"
// To build OpenCV into the project:
//    - Download opencv2.framework for iOS
//    - Insert framework into project's Frameworks group
//    - Make sure framework is included under the target's Build Phases -> Link Binary With Libraries.
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc_c.h>

@protocol VisualProcessDelegate <NSObject>

- (void)visualProcess:(const cv::Mat &)src dst:(cv::Mat &)dst;

@end


// To use the RosyWriterOpenCVRenderer, import this header in RosyWriterCapturePipeline.m
// and intialize _renderer to a RosyWriterOpenCVRenderer.

@interface RosyWriterOpenCVRenderer : NSObject <RosyWriterRenderer> {
    
}
@property(nonatomic ,weak, nullable) id<VisualProcessDelegate> delegate;


@end
