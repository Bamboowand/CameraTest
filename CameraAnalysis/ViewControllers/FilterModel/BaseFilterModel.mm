//
//  BaseFilterModel.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/9.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "BaseFilterModel.h"

@implementation BaseFilterModel
- (NSString *)getFilterName {
    return @"Camera";
}

- (NSArray *)getFilterUIArray {
    return filterUIArray_;
}

- (void)processFrameMat:(const Mat&) src output:(Mat &)dst {
    dst = src;
}
@end
