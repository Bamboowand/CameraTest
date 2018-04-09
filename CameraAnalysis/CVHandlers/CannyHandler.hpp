//
//  CannyHandler.hpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/31.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#ifndef CannyHandler_hpp
#define CannyHandler_hpp

#include <stdio.h>
#include "CVHandler.hpp"
class CannyHandler : public CVHandler {
public:
    CannyHandler();
    
    virtual void ProcessFrame(const Mat &src, Mat &dst);
    virtual const char* get_name();
    
    void set_threshold_1(double threshold_1);
    void set_threshold_2(double threshold_2);
    void set_aperture_size(int aperture_size);
    void set_gradient_l2(bool gradient_l2);
    
private:
    double threshold_1_ = 40, threshold_2_ = 160;
    int aperture_size_ = 3;
    bool gradient_l2_ = false;
    
};


#endif /* CannyHandler_hpp */
