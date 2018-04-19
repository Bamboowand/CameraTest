//
//  SobelHandler.cpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/24.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#include "SobelHandler.hpp"
SobleHandler::SobleHandler() {
    
}

void SobleHandler::ProcessFrame(const Mat &src, Mat &dst) {
    Mat soble_mat, sobelScaleAbs;
    
    if ( setting_map_ != NULL ) {
        int ksize = stoi(setting_map_->at("ksize"));
        dx_ = stoi(setting_map_->at("dx"));
        dy_ = stoi(setting_map_->at("dy"));
        ksize_ = ksize % 2 == 0 ? ksize + 1 : ksize;
        if ( ksize_ <= dx_ ) {
            dx_ = ksize_ - 1;
            if ( ksize_ <= dy_ )
                dy_ = ksize_ - 1;
        }
        else if ( ksize_ <= dy_ ) {
            dy_ = ksize_ - 1;
            if ( ksize_ <= dx_ )
                dx_ = ksize_ - 1;
        }
        else {
            
        }
    }
    
    cvtColor(src, image_bgr_, CV_BGRA2BGR);
    cvtColor(image_bgr_, gray_, CV_BGR2GRAY);
//    printf("dx = %d, dy = %d, ksize = %d\n",dx_, dy_, ksize_);
    cv::Sobel(gray_, soble_mat, CV_32F, dx_, dy_, ksize_);
    cv::convertScaleAbs(soble_mat, sobelScaleAbs, 1, 0);
    cvtColor(sobelScaleAbs, dst, CV_GRAY2BGRA);
}

const char* SobleHandler::get_name() {
    return "Sobel Detection";
}

void SobleHandler::set_dx(int dx) {
    dx_ = dx;
}

void SobleHandler::set_dy(int dy) {
    dy_ = dy;
}

void SobleHandler::set_ksize(int ksize) {
    ksize_ = ksize;
}
