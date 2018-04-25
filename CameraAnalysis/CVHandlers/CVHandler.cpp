//
//  CVHandler.cpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/24.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#include "CVHandler.hpp"

CVHandler::CVHandler() {
    
};

void CVHandler::set_setting(map<string, string> &setting_map) {
    setting_map_ = &setting_map;
}


const char* CVHandler::get_name() {
    return "Camera";
}

void CVHandler::ProcessFrame(const Mat &src, Mat &dst) {
    dst = src;
}
