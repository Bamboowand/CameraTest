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
    SettingUITypeSwitch,
    SettingUITypeSlider
} SettingUIType;

typedef struct SliderUIValue {
    float max;
    float min;
    float value;
    bool oddValue = false;
    char* maxContract;
    char* minContract;
    SliderUIValue(float max_value, float min_value, float init_value, bool isOdd, char* maxAboutUI, char* minAboutUI): max(max_value), min(min_value), value(init_value), oddValue(isOdd), maxContract(maxAboutUI), minContract(minAboutUI) {};
} SliderUIValue;

typedef union SettingUIValue {
    bool switchValue;
    SliderUIValue sliderValue;
} SettingUIValue;


typedef struct SettingViewUI {
    char* uiname;
    SettingUIType type = SettingUITypeSwitch;
    SettingUIValue uivalue = { false };
} SettingViewUI;

typedef vector<SettingViewUI> FilterSetArray;
typedef vector<pair<string, FilterSetArray>> SettingData;

//typedef map<string, string> SettingDict;
//typedef map<string, SettingDict> FilterSetDict;

//typedef vector<pair<string, string>> s;
//typedef vector<pair<string, SettingDict>> FilterSetArr;

#endif /* CameraParameter_h */
