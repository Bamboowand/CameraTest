//
//  SobelFilterModel.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/12.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "SobelFilterModel.h"

@implementation SobelFilterModel
- (instancetype)init {
    if ( !self ) {
        self = [super init];
    }
    _dx = 1;
    _dy = 1;
    _ksize = 3;
    [self initUIArray];
    return self;
}

- (NSString *)getFilterName {
    return @"Sobel Filter";
}

- (void)processFrameMat:(const Mat&) src output:(Mat &)dst {
    if ( filterUIArray_ != nil ) {
        CellModel *cellModel0 = filterUIArray_[0];
        CellModel *cellModel1 = filterUIArray_[1];
        CellModel *cellModel2 = filterUIArray_[2];
        UISlider *slider0 = (UISlider *)cellModel0.control;
        UISlider *slider1 = (UISlider *)cellModel1.control;
        UISlider *slider2 = (UISlider *)cellModel2.control;
        
        _ksize = slider0.value;
        _dx = slider1.value;
        _dy = slider2.value;
    }
    
    Mat soble_mat, sobelScaleAbs;
    cvtColor(src, _image_bgr, CV_BGRA2BGR);
    cvtColor(_image_bgr, _gray, CV_BGR2GRAY);
    //    printf("dx = %d, dy = %d, ksize = %d\n",dx_, dy_, ksize_);
    cv::Sobel(_gray, soble_mat, CV_32F, _dx, _dy, _ksize);
    cv::convertScaleAbs(soble_mat, sobelScaleAbs, 1, 0);
    cvtColor(sobelScaleAbs, dst, CV_GRAY2BGRA);
}

- (void)initUIArray {
    CGFloat sliderWidth = [UIScreen mainScreen].bounds.size.width * 4 / 7;
    CGFloat sliderHeight = 20.0f;
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, sliderWidth, sliderHeight)];
    [slider addTarget:self action:@selector(ksizeSlider:) forControlEvents:UIControlEventValueChanged];
    slider.maximumValue = 31;
    slider.minimumValue = 3;
    slider.value = 3;
    CellModel* sliderCell1 = [[CellModel alloc] initWithTitle:@"Ksize" value:@"31" control:slider];
    

    UISlider *dxSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, sliderWidth, sliderHeight)];
    [dxSlider addTarget:self action:@selector(dxSliderChange:) forControlEvents:UIControlEventValueChanged];
    dxSlider.maximumValue = slider.value -1 ;
    dxSlider.minimumValue = 0;
    dxSlider.value = 0;
    CellModel *sliderCell2 = [[CellModel alloc] initWithTitle:@"dx size" value:@"3" control:dxSlider];
    
    UISlider *dySlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, sliderWidth, sliderHeight)];
    [dySlider addTarget:self action:@selector(dySliderChange:) forControlEvents:UIControlEventValueChanged];
    dySlider.maximumValue = slider.value;
    dySlider.minimumValue = 0;
    dySlider.value = 1;
    CellModel *sliderCell3 = [[CellModel alloc] initWithTitle:@"dy size" value:@"3" control:dySlider];

    
//    filterUIArray_ = [NSArray arrayWithObjects:slider, dxSlider, dySlider, nil];
    filterUIArray_ = [NSArray arrayWithObjects:sliderCell1, sliderCell2, sliderCell3, nil];
}

#pragma mark- UIAction
- (IBAction)ksizeSlider:(UISlider *)sender {
    if ( (int)sender.value % 2 == 0 )
        sender.value = (int)sender.value + 1;
    CellModel *cellModel = filterUIArray_[0];
    cellModel.value = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)sender.maximumValue];
    
    CellModel *cellModel1 = filterUIArray_[1];
    CellModel *cellModel2 = filterUIArray_[2];
    UISlider *slider1 = (UISlider *)cellModel1.control;
    UISlider *slider2 = (UISlider *)cellModel2.control;
    
    slider1.maximumValue = sender.value - 1;
    slider2.maximumValue = sender.value - 1;
    
    if ( (int)sender.value <=  (int)slider1.value ) {
        slider1.value = slider1.value - 1;
    }
    else if ( (int)sender.value <= (int)slider2.value ) {
        slider2.value = slider2.value - 1;
    }
    
    cellModel1.value = [NSString stringWithFormat:@"%d / %d", (int)slider1.value, (int)slider1.maximumValue];
    cellModel2.value = [NSString stringWithFormat:@"%d / %d", (int)slider2.value, (int)slider2.maximumValue];
    
}

- (IBAction)dxSliderChange:(UISlider *)sender {
    sender.value = (int)sender.value;
    CellModel *cellModel1 = filterUIArray_[1];
    CellModel *cellModel2 = filterUIArray_[2];
    UISlider *slider2 = (UISlider *)cellModel2.control;
    
    cellModel1.value = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)sender.maximumValue];
    slider2.minimumValue = sender.value == 0 ? 1 : 0;
    
}

- (IBAction)dySliderChange:(UISlider *)sender {
    sender.value = (int)sender.value;
    CellModel *cellModel1 = filterUIArray_[1];
    CellModel *cellModel2 = filterUIArray_[2];
    UISlider *slider1 = (UISlider *)cellModel1.control;
    
    cellModel2.value = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)sender.maximumValue];
    slider1.minimumValue = sender.value == 0 ? 1 : 0;
}


@end
