//
//  CameraParameter.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/4/19.
//  Copyright © 2018年 ChenWei. All rights reserved.
//




#ifndef CameraParameter_hpp
#define CameraParameter_hpp

#include <iostream>
#include <string>
#include <map>
#include <vector>

/*
 example:
 ksize:
 dx:
 dy:
 
 ksizeMax
 ksizemin
 dxMax
 dxMin
 dyMax
 dyMin
 
 Struct:
 {
    Name
    UI_Type{
            slider { Max, Min, Value }
            switch { BOOL }
    }
 }
 
 */
using namespace std;
typedef enum SettungUIType {
    SettungUITypeSlider,
    SettungUITypeSwitch
} SettingUIType;

typedef struct SliderUIValue {
    float max;
    float min;
    float value;
    bool oddValue = false;
    string maxContract = "";
    string minContract = "";
} SliderUIValue;

typedef union SettingUIValue {
    SliderUIValue sliderValue;
    bool switchValue;
} SettingUIValue;


typedef struct SettingViewUI {
    string uiname;
    SettingUIType type;
    SettingUIValue uivalue;
} SettingViewUI;

typedef vector<SettingViewUI> FilterSetArray;
typedef vector<pair<string, vector<FilterSetArray>>> SettingData;

//typedef map<string, string> SettingDict;
//typedef map<string, SettingDict> FilterSetDict;

//typedef vector<pair<string, string>> s;
//typedef vector<pair<string, SettingDict>> FilterSetArr;

#endif /* CameraParameter_h */
