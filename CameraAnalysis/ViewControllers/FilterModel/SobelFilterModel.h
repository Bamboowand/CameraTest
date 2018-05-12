//
//  SobelFilterModel.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/12.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFilterModel.h"

@interface SobelFilterModel : BaseFilterModel {
    int _dx, _dy, _ksize;
}

- (NSString *)getFilterName;
- (NSArray *)getFilterUIArray;
- (void)processFrameMat:(const Mat&) src output:(Mat &)dst;

@end
