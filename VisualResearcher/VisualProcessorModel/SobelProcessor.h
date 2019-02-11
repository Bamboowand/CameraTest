//
//  SobelProcessor.h
//  VisualResearcher
//
//  Created by ChenWei on 2019/2/11.
//  Copyright © 2019年 Jacob. All rights reserved.
//

#import "VisualBasedProcessor.h"

NS_ASSUME_NONNULL_BEGIN

@interface SobelProcessor : VisualBasedProcessor

- (NSString *)getName;
- (void)process:(const cv::Mat &)src dst:(cv::Mat &)dst;
- (void)setUI:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
