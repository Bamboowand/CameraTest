//
//  ThresholdHanlder.cpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/31.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#include "ThresholdHanlder.hpp"

ThresholdHandler::ThresholdHandler() {
    
}

void ThresholdHandler::ProcessFrame(const Mat &src, Mat &dst) {
    Mat threshold_dst;
//    cvtColor(src, image_bgr_, CV_BGRA2BGR);
//    cvtColor(image_bgr_, gray_, CV_BGR2GRAY);
    cvtColor(src, gray_, CV_BGRA2GRAY);
    threshold(gray_, threshold_dst, threshold_, maxvalue_, type_);
    cvtColor(threshold_dst, dst, CV_GRAY2BGRA);
}

const char* ThresholdHandler::get_name() {
    return "Brightness Detection";
}

void ThresholdHandler::set_threshold(double threshold) {
    threshold_ = threshold;
}

void ThresholdHandler::set_maxvalue(double maxvalue) {
    maxvalue_ = maxvalue;
}
void ThresholdHandler::set_type(int type) {
    type_ = type;
}
