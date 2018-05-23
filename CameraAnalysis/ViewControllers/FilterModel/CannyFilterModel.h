//
//  CannyFilterModel.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/13.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "BaseFilterModel.h"

@interface CannyFilterModel : BaseFilterModel {
    double _threshold_1, _threshold_2;
    int _aperture_size;
    bool _gradient_l2;
}

- (NSString *)getFilterName;
- (void)processFrameMat:(const Mat&) src output:(Mat &)dst;
@end
