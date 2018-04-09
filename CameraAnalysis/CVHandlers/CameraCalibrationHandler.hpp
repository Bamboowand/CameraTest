//
//  CameraCalibrationHandler.hpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/24.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#ifndef CameraCalibrationHandler_hpp
#define CameraCalibrationHandler_hpp

#include <stdio.h>
#include "CVHandler.hpp"
class CameraCalibrationHandler : public CVHandler {
public:
    CameraCalibrationHandler();
    virtual void ProcessFrame(const Mat &src, Mat &dst);
    virtual const char* get_name();
};
#endif /* CameraCalibrationHandler_hpp */
