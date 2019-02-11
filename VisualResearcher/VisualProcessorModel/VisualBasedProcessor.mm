//
//  VisualProcessor.m
//  VisualResearcher
//
//  Created by ChenWei on 2019/2/11.
//  Copyright © 2019年 Jacob. All rights reserved.
//

#import "VisualBasedProcessor.h"

@implementation VisualBasedProcessor

- (NSString *)getName {
    return @"Based Process";
}

- (void)process:(const cv::Mat &)src dst:(cv::Mat &)dst {
    dst = src.clone();
}

- (void)setUI:(UIView *)view {
    
}

@end
