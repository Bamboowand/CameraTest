//
//  BaseFilterModel.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/9.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModel.h"
#include <opencv2/opencv.hpp>


using namespace cv;
using namespace std;

@interface BaseFilterModel : NSObject {
    NSArray *filterUIArray_;
    Mat _image_bgr;
    Mat _gray;
}

- (NSString *)getFilterName;
- (NSArray *)getFilterUIArray;
- (void)processFrameMat:(const Mat&) src output:(Mat &)dst;

@end
