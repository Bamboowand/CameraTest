//
//  SettingView.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/25.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "SettingView.h"

@implementation SettingView

- (instancetype)initWithFrame:(CGRect)frame Style:(SettingStyle)style {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor darkGrayColor];
    self.layer.cornerRadius = 28.0f;
    self.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor lightTextColor]);
    self.layer.borderWidth = 2;
    self.layer.shadowColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    self.alpha = 0.8f;
    _style = style;
    if ( _style == FilterStyle1 ) {
        [self setViewForFilterStyle1];
//        [self testSetsetViewForFilterStyle1];
    }
    else if ( _style == FilterStyle2 ) {
        [self setViewForFilterStyle2];
    }
    else {
        [self setupLayout];
    }
    
    return self;
}

#pragma mark- Layout
- (void)setupLayout {
    self.slider1Title = [[UILabel alloc] init];
    self.slider1 = [[UISlider alloc] init];
    self.slider1ValueLabel = [[UILabel alloc] init];
    
    UIView *view1 = [self setLayoutWithSlider:self.slider1 titleLabel:self.slider1Title valueLabel:self.slider1ValueLabel action:@selector(test:) Frame:CGRectMake(20, 20, self.frame.size.width -40, 60)];
    self.slider1Title.text = @"Test";
    self.slider1.maximumValue = 100;
    self.slider1.minimumValue = 0;
    self.slider1.value = 50;
    self.slider1ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_slider1.value, (int)_slider1.maximumValue];

    
    [self addSubview:view1];
}

- (IBAction)test:(UISlider *)sender {
    sender.value = (int)sender.value;
    self.slider1ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_slider1.value, (int)_slider1.maximumValue];
}

- (UIView *)setLayoutWithSlider:(UISlider *)slider titleLabel:(UILabel *)title valueLabel:(UILabel *)value action:(SEL)action Frame:(CGRect)frame {
    CGFloat pointX = 6.0f;
    CGFloat pointY = 0;
    CGFloat step = 2.0f;
    
    UIView *layoutView = [[UIView alloc] initWithFrame:frame];
    title.frame = CGRectMake(pointX, pointY, frame.size.width / 2, frame.size.height / 2);
//    title = [[UILabel alloc] initWithFrame:CGRectMake(pointX, pointY, frame.size.width / 2, frame.size.height / 2)];
    title.enabled = NO;
    [title setTextColor:[UIColor blueColor]];
    [layoutView addSubview:title];
    pointY += (frame.size.height / 2 + step);
    slider.frame =  CGRectMake(pointX, pointY, frame.size.width * 5 / 7, frame.size.height / 2 - step);
//    slider = [[UISlider alloc] initWithFrame:CGRectMake(pointX, pointY, frame.size.width * 3 / 4, frame.size.height / 2 - step)];
    [slider addTarget:self action:action forControlEvents:UIControlEventValueChanged];
    [layoutView addSubview:slider];
    value.frame = CGRectMake(pointX + slider.frame.size.width, pointY, frame.size.width * 2  / 7, slider.frame.size.height);
//    value = [[UILabel alloc] initWithFrame:CGRectMake(pointX + slider.frame.size.width, pointY, frame.size.width / 4, slider.frame.size.height)];
    value.enabled = NO;
    [layoutView addSubview:value];
    return layoutView;
}

#pragma mark- FilterStyle1
//- (void)testSetsetViewForFilterStyle1 {
//    CGFloat width = self.frame.size.width - 12;
//    CGFloat height = 60.0f;
//    CGFloat positionX = 6.0f;
//    CGFloat positionY = 20.0f;
//
//    _slider1 = [[UISlider alloc] init];
//    _slider2 = [[UISlider alloc] init];
//    _slider3 = [[UISlider alloc] init];
//    _slider1Title = [[UILabel alloc] init];
//    _slider2Title = [[UILabel alloc] init];
//    _slider3Title = [[UILabel alloc] init];
//    _slider1ValueLabel = [[UILabel alloc] init];
//    _slider2ValueLabel = [[UILabel alloc] init];
//    _slider3ValueLabel = [[UILabel alloc] init];
//
//    UIView *subView1 = [self setLayoutWithSlider:_slider1 titleLabel:_slider1Title valueLabel:_slider1ValueLabel action:@selector(changeStepSlider:) Frame:CGRectMake(positionX, positionY, width, height)];
//    positionY += height;
//    _slider1Title.text = @"Kernel Size";
//    _slider1.maximumValue = 31;
//    _slider1.minimumValue = 3;
//    _slider1.value = 3;
//    _slider1ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_slider1.value, (int)_slider1.maximumValue];
//    [self addSubview:subView1];
//
//    UIView *subView2 = [self setLayoutWithSlider:_slider2 titleLabel:_slider2Title valueLabel:_slider2ValueLabel action:@selector(changeSlider:) Frame:CGRectMake(positionX, positionY, width, height)];
//    positionY += height;
//    _slider2Title.text = @"Dx Value";
//    _slider2.maximumValue = _slider1.value - 1;
//    _slider2.minimumValue = 0;
//    _slider2.value = 1;
//    _slider2.tag = 0;
//    _slider2ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_slider2.value, (int)_slider2.maximumValue];
//    [self addSubview:subView2];
//
//    UIView *subView3 = [self setLayoutWithSlider:_slider3 titleLabel:_slider3Title valueLabel:_slider3ValueLabel action:@selector(changeSlider:) Frame:CGRectMake(positionX, positionY, width, height)];
//    positionY += height;
//    _slider3Title.text = @"Dy Value";
//    _slider3.maximumValue = _slider1.value - 1;
//    _slider3.minimumValue = 0;
//    _slider3.value = 0;
//    _slider3.tag = 1;
//    _slider3ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_slider3.value, (int)_slider3.maximumValue];
//    [self addSubview:subView3];
//}

//- (IBAction)changeSlider:(UISlider*)sender {
//    sender.value = (int)sender.value;
//    if (sender.tag == 0) {
//        _slider3.minimumValue = sender.value == 0 ? 1: 0;
//        if ( sender.value == 0 )
//            _slider3.value = 1;
//    }else if ( sender.tag == 1 ) {
//        _slider2.minimumValue = sender.value == 0 ? 1: 0;
//        if ( sender.value == 0 )
//            _slider2.value = 1;
//    }
//    _slider2ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)_slider2.maximumValue];
//    _slider3ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)_slider3.maximumValue];
//}
//
//- (IBAction)changeStepSlider:(UISlider *)sender {
//    if ( (int)sender.value % 2 == 0 )
//        sender.value = (int)sender.value + 1;
//    _slider2.maximumValue = sender.value - 1;
//    _slider3.maximumValue = sender.value - 1;
//    if ( (int)sender.value <= (int)_slider2.value ) {
//        _slider2.value = sender.value - 1;
//    }
//    else if ( (int)sender.value <= (int)_slider3.value ) {
//        _slider3.value = sender.value - 1;
//    }
//    else {
//
//    }
//    sender.value = (int)sender.value;
//    _slider1ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)_slider1.maximumValue];
//    _slider2ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_slider2.value, (int)_slider2.maximumValue];
//    _slider3ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_slider3.value, (int)_slider3.maximumValue];
//}

- (void)setViewForFilterStyle1 {
    CGFloat width = self.frame.size.width;
    CGFloat height = 27;
    CGFloat step = 40;
    CGFloat positionX = 6;
    CGFloat positionY = 0;
    
    UILabel *ksizeTitle = [[UILabel alloc] initWithFrame:CGRectMake(positionX, 20, 270, 20)];
    ksizeTitle.text = @"Kernel Size";
    ksizeTitle.enabled = NO;
    [self addSubview:ksizeTitle];
    positionY = ksizeTitle.frame.origin.y + ksizeTitle.frame.size.height + 10;
    self.ksizeSlider = [[UISlider alloc] initWithFrame:CGRectMake(positionX, positionY, width - 12 - 60, height)];
    self.ksizeSlider.maximumValue = 31 ;
    self.ksizeSlider.minimumValue = 3;
    self.ksizeSlider.value = 3;
    [self.ksizeSlider addTarget:self action:@selector(changeStepSlider:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.ksizeSlider];
    self.ksizeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionX + self.ksizeSlider.frame.size.width, positionY, 60, height)];
    self.ksizeValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.ksizeSlider.value, (int)self.ksizeSlider.maximumValue];
    self.ksizeValueLabel.enabled = NO;
    [self addSubview:self.ksizeValueLabel];
    
    positionY += (self.ksizeSlider.frame.size.height + step);
    UILabel *dxTitle = [[UILabel alloc] initWithFrame:CGRectMake(positionX, positionY, 270, 20)];
    dxTitle.text = @"Dx Value";
    dxTitle.enabled = NO;
    [self addSubview:dxTitle];
    positionY += dxTitle.frame.size.height + 10;
    self.dxSlider = [[UISlider alloc] initWithFrame:CGRectMake(positionX, positionY, width - 12 - 60, height)];
    self.dxSlider.maximumValue = self.ksizeSlider.value - 1;
    self.dxSlider.minimumValue = 0;
    self.dxSlider.value = 1;
    self.dxSlider.tag = 0;
    [self.dxSlider addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.dxSlider];
    self.dxValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionX + self.dxSlider.frame.size.width, positionY, 60, height)];
    self.dxValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.dxSlider.value, (int)self.dxSlider.maximumValue];
    self.dxValueLabel.enabled = NO;
    [self addSubview:self.dxValueLabel];
    
    positionY += (self.ksizeSlider.frame.size.height + step);
    UILabel *dyTitle = [[UILabel alloc] initWithFrame:CGRectMake(positionX, positionY, 270, 20)];
    dyTitle.text = @"Dy Value";
    dyTitle.enabled = NO;
    [self addSubview:dyTitle];
    positionY += dyTitle.frame.size.height + 10;
    self.dySlider = [[UISlider alloc] initWithFrame:CGRectMake(positionX, positionY, width -12 - 60, height)];
    self.dySlider.maximumValue = self.ksizeSlider.value - 1;
    self.dySlider.minimumValue = 0;
    self.dySlider.value = 1;
    self.dySlider.tag = 1;
    [self.dySlider addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.dySlider];
    self.dyValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionX + self.dySlider.frame.size.width, positionY, 60, height)];
    self.dyValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.dySlider.value, (int)self.dySlider.maximumValue];
    self.dyValueLabel.enabled = NO;
    [self addSubview:self.dyValueLabel];

}

- (IBAction)changeSlider:(UISlider*)sender {
    sender.value = (int)sender.value;
    if (sender.tag == 0) {
        self.dxValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)self.dxSlider.maximumValue];
        self.dySlider.minimumValue = sender.value == 0 ? 1: 0;
    }else if ( sender.tag == 1 ) {
        self.dyValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)self.dySlider.maximumValue];
        self.dxSlider.minimumValue = sender.value == 0 ? 1: 0;
    }
}

- (IBAction)changeStepSlider:(UISlider *)sender {
    if ( (int)sender.value % 2 == 0 )
        sender.value = (int)sender.value + 1;
    self.dxSlider.maximumValue = sender.value - 1;
    self.dySlider.maximumValue = sender.value - 1;
    if ( (int)sender.value <= (int)self.dxSlider.value ) {
        self.dxSlider.value = sender.value - 1;
    }
    else if ( (int)sender.value <= (int)self.dySlider.value ) {
        self.dySlider.value = sender.value - 1;
    }
    else {

    }
    sender.value = (int)sender.value;
    self.ksizeValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)self.ksizeSlider.maximumValue];
    self.dxValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.dxSlider.value, (int)self.dxSlider.maximumValue];
    self.dyValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.dySlider.value, (int)self.dySlider.maximumValue];
}

#pragma mark- FilterStyle2
- (void)setViewForFilterStyle2 {
    CGFloat width = self.frame.size.width;
    CGFloat height = 27;
    CGFloat step = 40;
    CGFloat positionX = 6;
    CGFloat positionY = 0;
    
    UILabel *threshold_1Title = [[UILabel alloc] initWithFrame:CGRectMake(positionX, 20, 270, 20)];
    threshold_1Title.text = @"Threshold 1";
    threshold_1Title.enabled = NO;
    [self addSubview:threshold_1Title];
    positionY = threshold_1Title.frame.origin.y + threshold_1Title.frame.size.height + 10;
    self.threshold_1Slider = [[UISlider alloc] initWithFrame:CGRectMake(positionX, positionY, width - 12 - 100, height)];
    self.threshold_1Slider.maximumValue = 255 ;
    self.threshold_1Slider.minimumValue = 0;
    self.threshold_1Slider.value = 40;
    self.threshold_1Slider.tag = 0;
    [self.threshold_1Slider addTarget:self action:@selector(changeStepSlider_Style2:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.threshold_1Slider];
    self.threshold_1ValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionX + self.threshold_1Slider.frame.size.width, positionY, 100, height)];
    self.threshold_1ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.threshold_1Slider.value, (int)self.threshold_1Slider.maximumValue];
    self.threshold_1ValueLabel.enabled = NO;
    [self addSubview:self.threshold_1ValueLabel];
    
    positionY += (self.threshold_1ValueLabel.frame.size.height + step);
    UILabel *threshold_2Title = [[UILabel alloc] initWithFrame:CGRectMake(positionX, positionY, 270, 20)];
    threshold_2Title.text = @"Threshold 2";
    threshold_2Title.enabled = NO;
    [self addSubview:threshold_2Title];
    positionY += threshold_2Title.frame.size.height + 10;
    self.threshold_2Slider = [[UISlider alloc] initWithFrame:CGRectMake(positionX, positionY, width - 12 - 100, height)];
    self.threshold_2Slider.maximumValue = 255;
    self.threshold_2Slider.minimumValue = 0;
    self.threshold_2Slider.value = 160;
    self.threshold_2Slider.tag = 1;
    [self.threshold_2Slider addTarget:self action:@selector(changeStepSlider_Style2:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.threshold_2Slider];
    self.threshold_2ValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionX + self.threshold_2Slider.frame.size.width, positionY, 100, height)];
    self.threshold_2ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.threshold_2Slider.value, (int)self.threshold_2Slider.maximumValue];
    self.threshold_2ValueLabel.enabled = NO;
    [self addSubview:self.threshold_2ValueLabel];
    
    positionY += (self.threshold_1ValueLabel.frame.size.height + step);
    UILabel *apertureSizeTitle = [[UILabel alloc] initWithFrame:CGRectMake(positionX, positionY, 270, 20)];
    apertureSizeTitle.text = @"Aperture Size";
    apertureSizeTitle.enabled = NO;
    [self addSubview:apertureSizeTitle];
    positionY += apertureSizeTitle.frame.size.height + 10;
    self.apertureSizeSlider = [[UISlider alloc] initWithFrame:CGRectMake(positionX, positionY, width -12 - 60, height)];
    self.apertureSizeSlider.maximumValue = 7;
    self.apertureSizeSlider.minimumValue = 3;
    self.apertureSizeSlider.value = 3;
    self.apertureSizeSlider.tag = 2;
    [self.apertureSizeSlider addTarget:self action:@selector(changeStepSlider_Style2:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.apertureSizeSlider];
    self.apertureSizeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionX + self.apertureSizeSlider.frame.size.width, positionY, 60, height)];
    self.apertureSizeValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.apertureSizeSlider.value, (int)self.apertureSizeSlider.maximumValue];
    self.apertureSizeValueLabel.enabled = NO;
    [self addSubview:self.apertureSizeValueLabel];

}

-(IBAction)changeStepSlider_Style2:(UISlider *)sender {
    sender.value = (int)sender.value;
    if ( sender.tag == 0 ) {
        self.threshold_1ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.threshold_1Slider.value, (int)self.threshold_1Slider.maximumValue];
    }
    else if ( sender.tag == 1 ) {
        self.threshold_2ValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.threshold_2Slider.value, (int)self.threshold_2Slider.maximumValue];
    }else if ( sender.tag == 2 ) {
        if ( (int)sender.value % 2 == 0 ) {
            sender.value = sender.value + 1;
        }
    self.apertureSizeValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.apertureSizeSlider.value, (int)self.apertureSizeSlider.maximumValue];
    }
    else {}
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
