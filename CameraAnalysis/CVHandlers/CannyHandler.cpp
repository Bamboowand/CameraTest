//
//  CannyHandler.cpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/31.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#include "CannyHandler.hpp"
CannyHandler::CannyHandler() {
    
}

void CannyHandler::ProcessFrame(const Mat &src, Mat &dst) {
    if ( setting_map_ != NULL ) {
        threshold_1_ = stoi(setting_map_->at("threshold_1"));
        threshold_2_ = stoi(setting_map_->at("threshold_2"));
        aperture_size_ = stoi(setting_map_->at("aperture_size"));
        gradient_l2_ = stoi(setting_map_->at("gradient_l2"));
    }
    
    Mat canny_dst;
    cvtColor(src, gray_, CV_BGRA2GRAY);
    Canny(gray_, canny_dst, threshold_1_, threshold_2_, aperture_size_, gradient_l2_);
    cvtColor(canny_dst, dst, CV_GRAY2BGRA);
}

const char* CannyHandler::get_name() {
    return "Canny Detection";
}

void CannyHandler::set_threshold_1(double threshold_1) {
    threshold_1_ = threshold_1;
}

void CannyHandler::set_threshold_2(double threshold_2) {
    threshold_2_ = threshold_2;
}

void CannyHandler::set_aperture_size(int aperture_size) {
    aperture_size_ = aperture_size;
}

void CannyHandler::set_gradient_l2(bool gradient_l2) {
    gradient_l2_ = gradient_l2;
}
