//
//  SobelFilterModel.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/12.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "SobelFilterModel.h"

@implementation SobelFilterModel
- (instancetype)init {
    if ( !self ) {
        self = [super init];
    }
    _dx = 1;
    _dy = 1;
    _ksize = 3;
    return self;
}

- (NSString *)getFilterName {
    return @"Sobel Filter";
}

- (NSArray *)getFilterUIArray {
    return filterUIArray_;
}

- (void)processFrameMat:(const Mat&) src output:(Mat &)dst {
    Mat image_bgr;
    Mat gray;
    Mat soble_mat, sobelScaleAbs;
    cvtColor(src, image_bgr, CV_BGRA2BGR);
    cvtColor(image_bgr, gray, CV_BGR2GRAY);
    //    printf("dx = %d, dy = %d, ksize = %d\n",dx_, dy_, ksize_);
    cv::Sobel(gray, soble_mat, CV_32F, _dx, _dy, _ksize);
    cv::convertScaleAbs(soble_mat, sobelScaleAbs, 1, 0);
    cvtColor(sobelScaleAbs, dst, CV_GRAY2BGRA);
}

@end
