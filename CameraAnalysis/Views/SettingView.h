//
//  SettingView.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/25.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum SettingStyle{
    FilterStyle1,
    FilterStyle2,
    None
}SettingStyle;

@interface SettingView : UIView {
    SettingStyle _style;
}

@property(nonatomic)UISlider *slider1;
@property(nonatomic)UILabel *slider1Title;
@property(nonatomic)UILabel *slider1ValueLabel;

@property(nonatomic)UISlider *slider2;
@property(nonatomic)UILabel *slider2Title;
@property(nonatomic)UILabel *slider2ValueLabel;

@property(nonatomic)UISlider *slider3;
@property(nonatomic)UILabel *slider3Title;
@property(nonatomic)UILabel *slider3ValueLabel;

@property(nonatomic)UISlider *slider4;
@property(nonatomic)UILabel *slider4Title;
@property(nonatomic)UILabel *slider4ValueLabel;



@property(nonatomic)UISlider *dxSlider;
@property(nonatomic)UILabel  *dxValueLabel;
@property(nonatomic)UISlider *dySlider;
@property(nonatomic)UILabel  *dyValueLabel;
@property(nonatomic)UISlider *ksizeSlider;
@property(nonatomic)UILabel  *ksizeValueLabel;

@property(nonatomic)UISlider *threshold_1Slider;
@property(nonatomic)UILabel  *threshold_1ValueLabel;
@property(nonatomic)UISlider *threshold_2Slider;
@property(nonatomic)UILabel  *threshold_2ValueLabel;
@property(nonatomic)UISlider *apertureSizeSlider;
@property(nonatomic)UILabel  *apertureSizeValueLabel;
@property(nonatomic)UISwitch *gradient_l2Switch;

- (instancetype)initWithFrame:(CGRect)frame Style:(SettingStyle)style;

@end
