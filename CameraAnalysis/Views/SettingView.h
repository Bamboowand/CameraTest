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
    FilterStyle2
}SettingStyle;

@interface SettingView : UIView {
    SettingStyle _style;
}
@property(nonatomic)UISlider *dxSlider;
@property(nonatomic)UILabel  *dxValueLabel;
@property(nonatomic)UISlider *dySlider;
@property(nonatomic)UILabel  *dyValueLabel;
@property(nonatomic)UISlider *ksizeSlider;
@property(nonatomic)UILabel  *ksizeValueLabel;

- (instancetype)initWithFrame:(CGRect)frame Style:(SettingStyle)style;

@end
