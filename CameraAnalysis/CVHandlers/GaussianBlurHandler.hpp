//
//  GaussianBlurHandler.hpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/30.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#ifndef GaussianBlurHandler_hpp
#define GaussianBlurHandler_hpp

#include <stdio.h>
#include "CVHandler.hpp"
class GaussianBlurHandler : public CVHandler {
public:
    GaussianBlurHandler();
    
    virtual void ProcessFrame(const Mat&src, Mat &dst);
    virtual const char* get_name();
    
    void EnableGrayMode(bool enable);
    void set_ksize(int ksize);
    void set_sigma_x(double sigma_x);
    void set_sigma_y(double sigma_y);
    
private:
    bool enable_gray_mode_ = true;
    int ksize_ = 7;//odd
    double sigma_x_ = 5;
    double sigma_y_ = 5;
    
};
#endif /* GaussianBlurHandler_hpp */
