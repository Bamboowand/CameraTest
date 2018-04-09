//
//  SobelHandler.hpp
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/24.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#ifndef SobelHandler_hpp
#define SobelHandler_hpp

#include <stdio.h>
#include "CVHandler.hpp"

class SobleHandler : public CVHandler {
public:
    SobleHandler();
    
    virtual void ProcessFrame(const Mat &src, Mat &dst);
    virtual const char* get_name();
    
    void set_dx(int dx);
    void set_dy(int dy);
    void set_ksize(int ksize);
private:
    int dx_ = 1, dy_ = 1, ksize_ = 3;
};

#endif /* SobelHandler_hpp */
