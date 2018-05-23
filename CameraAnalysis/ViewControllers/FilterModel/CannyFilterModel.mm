//
//  CannyFilterModel.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/13.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "CannyFilterModel.h"

@implementation CannyFilterModel
- (instancetype)init {
    if ( !self )
        self = [super init];
    _threshold_1 = 40;
    _threshold_2 = 160;
    _aperture_size = 3;
    _gradient_l2 = false;
    
    [self initUIArray];
    
    return self;
}

- (NSString *)getFilterName {
    return @"Canny Detection";
}
- (void)processFrameMat:(const Mat&) src output:(Mat &)dst {
    if ( filterUIArray_ != nil ) {
        CellModel *cellModel0 = filterUIArray_[0];
        CellModel *cellModel1 = filterUIArray_[1];
        CellModel *cellModel2 = filterUIArray_[2];
        UISlider *slider0 = (UISlider *)cellModel0.control;
        UISlider *slider1 = (UISlider *)cellModel1.control;
        UISlider *slider2 = (UISlider *)cellModel2.control;
        
        _threshold_1 = slider0.value;
        _threshold_2 = slider1.value;
        _aperture_size = slider2.value;
    }
    
    Mat canny_dst;
    cvtColor(src, _gray, CV_BGRA2GRAY);
    Canny(_gray, canny_dst, _threshold_1, _threshold_2, _aperture_size, _gradient_l2);
    cvtColor(canny_dst, dst, CV_GRAY2BGRA);
}

- (void)initUIArray {
    CGFloat sliderWidth = [UIScreen mainScreen].bounds.size.width * 4 / 7;
    CGFloat sliderHeight = 20.0f;
    UISlider *threshold1Slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, sliderWidth, sliderHeight)];
    [threshold1Slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    threshold1Slider.maximumValue = 255;
    threshold1Slider.minimumValue = 0;
    threshold1Slider.value = 40;
    threshold1Slider.tag = 0;
    CellModel* sliderCell1 = [[CellModel alloc] initWithTitle:@"threshold 1" value:[NSString stringWithFormat:@"%d / %d", (int)threshold1Slider.value, (int)threshold1Slider.maximumValue] control:threshold1Slider];
    
    
    UISlider *threshold2Slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, sliderWidth, sliderHeight)];
    [threshold2Slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    threshold2Slider.maximumValue = 255;
    threshold2Slider.minimumValue = 0;
    threshold2Slider.value = 160;
    threshold2Slider.tag = 1;
    CellModel *sliderCell2 = [[CellModel alloc] initWithTitle:@"threshold 2" value:[NSString stringWithFormat:@"%d / %d", (int)threshold2Slider.value, (int)threshold2Slider.maximumValue] control:threshold2Slider];
    
    UISlider *apertureSizeSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, sliderWidth, sliderHeight)];
    [apertureSizeSlider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    apertureSizeSlider.maximumValue = 7;
    apertureSizeSlider.minimumValue = 3;
    apertureSizeSlider.value = 3;
    apertureSizeSlider.tag = 2;
    CellModel *sliderCell3 = [[CellModel alloc] initWithTitle:@"Aperture Size" value:[NSString stringWithFormat:@"%d / %d", (int)apertureSizeSlider.value, (int)apertureSizeSlider.maximumValue] control:apertureSizeSlider];
    
    
    
    
    //    filterUIArray_ = [NSArray arrayWithObjects:slider, dxSlider, dySlider, nil];
    filterUIArray_ = [NSArray arrayWithObjects:sliderCell1, sliderCell2, sliderCell3, nil];
}

- (IBAction)changeValue:(UISlider *)sender {
    sender.value = (int)sender.value;
    if ( sender.tag == 0 ) {
        CellModel *cell1 = filterUIArray_[0];
        UISlider *slider = (UISlider *)cell1.control;
        cell1.value = [NSString stringWithFormat:@"%d / %d", (int)slider.value, (int)slider.maximumValue];
    }
    else if ( sender.tag == 1 ) {
        CellModel *cell2 = filterUIArray_[1];
        UISlider *slider = (UISlider *)cell2.control;
        cell2.value = [NSString stringWithFormat:@"%d / %d", (int)slider.value, (int)slider.maximumValue];
    }
    else if ( sender.tag == 2 ) {
        if ( (int)sender.value % 2 == 0) {
            sender.value = sender.value + 1;
        }
        CellModel *cell3 = filterUIArray_[2];
        UISlider *slider = (UISlider *)cell3.control;
        cell3.value = [NSString stringWithFormat:@"%d / %d", (int)slider.value, (int)slider.maximumValue];
    }
    else {
        
    }
}
@end
