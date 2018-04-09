//
//  ThresholdHanlder.hpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/31.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#ifndef ThresholdHanlder_hpp
#define ThresholdHanlder_hpp

#include <stdio.h>
#include "CVHandler.hpp"

class ThresholdHandler : public CVHandler {
public:
    ThresholdHandler();
    
    virtual void ProcessFrame(const Mat &src, Mat &dst);
    virtual const char* get_name();
    
    void set_threshold(double threshold);
    void set_maxvalue(double maxvalue);
    void set_type(int type);
    
private:
    double threshold_ = 125, maxvalue_ = 255;
    int type_ = THRESH_BINARY;
};

#endif /* ThresholdHanlder_hpp */
