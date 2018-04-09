//
//  GaussianBlurHandler.cpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/30.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#include "GaussianBlurHandler.hpp"
GaussianBlurHandler::GaussianBlurHandler() {
    
}

void GaussianBlurHandler::ProcessFrame(const Mat&src, Mat &dst) {
    Mat gaussian_dst;
    cvtColor(src, image_bgr_, CV_BGRA2BGR);
    if ( setting_map_ != NULL ) {
        enable_gray_mode_ = stoi(setting_map_->at("EnableGrayMode"));
        ksize_ = stoi(setting_map_->at("ksize"));
        sigma_x_ = stod(setting_map_->at("sigma_x"));
        sigma_y_ = stod(setting_map_->at("sigma_y"));
    }
    
    if ( enable_gray_mode_ ) {
        cvtColor(image_bgr_, gray_, CV_BGR2GRAY);
        GaussianBlur(gray_, gaussian_dst, Size(ksize_, ksize_), sigma_x_, sigma_y_);
        cvtColor(gaussian_dst, dst, CV_GRAY2BGRA);
    }
    else {
        GaussianBlur(image_bgr_, gaussian_dst, Size(ksize_, ksize_), sigma_x_, sigma_y_);
        cvtColor(gaussian_dst, dst, CV_BGR2BGRA);
    }
    
    if ( gaussian_dst.channels() == 3 ) {
        
    } else if ( gaussian_dst.channels() == 1 ){
        
    }
    else {
        gaussian_dst.copyTo(dst);
    }
}

const char* GaussianBlurHandler::get_name() {
    return "Gaussian Blur";
}

void GaussianBlurHandler::EnableGrayMode(bool enable) {
    enable_gray_mode_ = enable;
}
void GaussianBlurHandler::set_ksize(int ksize) {
    ksize_ = ksize;
}
void GaussianBlurHandler::set_sigma_x(double sigma_x) {
    sigma_x_ = sigma_x;
}
void GaussianBlurHandler::set_sigma_y(double sigma_y) {
    sigma_y_ = sigma_y;
}
