//
//  CVHandler.hpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/24.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#ifndef CVHandler_hpp
#define CVHandler_hpp

#include <stdio.h>
#include <opencv2/opencv.hpp>
#include "CameraParameter.hpp"

using namespace std;
using namespace cv;

class CVHandler {
public:
    CVHandler();
    void set_setting(map<string, string> &setting_map);
//    void set_setting(FilterSetDict &setting_dict);
    virtual void ProcessFrame(const Mat &src, Mat &dst);
    virtual const char* get_name();
    
    map<string, string> *setting_map_;
//    FilterSetDict *setting_dict_;
    Mat image_bgr_;
    Mat gray_;
};

#endif /* CVHandler_hpp */
