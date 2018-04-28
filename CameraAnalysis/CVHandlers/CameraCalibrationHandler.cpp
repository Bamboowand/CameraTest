//
//  CameraCalibrationHandler.cpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/24.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#include "CameraCalibrationHandler.hpp"
CameraCalibrationHandler::CameraCalibrationHandler() {
    
}

void CameraCalibrationHandler::ProcessFrame(const Mat &src, Mat &dst) {
    dst = src;
}

const char* CameraCalibrationHandler::get_name() {
    return "Camera Calibration";
}
