//
//  SobelProcessor.m
//  VisualResearcher
//
//  Created by ChenWei on 2019/2/11.
//  Copyright © 2019年 Jacob. All rights reserved.
//

#import "SobelProcessor.h"

@implementation SobelProcessor

- (NSString *)getName {
    return @"Sobel Process";
}

- (void)process:(const cv::Mat &)src dst:(cv::Mat &)dst {
    cv::Mat gray;
    cv::cvtColor(src, gray, CV_BGRA2GRAY);
    cv::cvtColor(gray, dst, CV_GRAY2BGRA);
}

- (void)setUI:(UIView *)view {
    
}

@end
