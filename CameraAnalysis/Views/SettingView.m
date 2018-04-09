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
    if ( _style == FilterStyle1 )
        [self setViewForFilterStyle1];
    
    return self;
}

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
    if (sender.tag == 0) {
        self.dxValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)self.dxSlider.maximumValue];
        self.dySlider.minimumValue = sender.value == 0 ? 1: 0;
    }else if ( sender.tag == 1 ) {
        self.dyValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)self.dySlider.maximumValue];
        self.dxSlider.minimumValue = sender.value == 0 ? 1: 0;
    }
    sender.value = (int)sender.value;
}

- (IBAction)changeStepSlider:(UISlider *)sender {
    if ( sender.value / 2 == 0 )
        sender.value++;
    self.ksizeValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)self.ksizeSlider.maximumValue];
    self.dxSlider.maximumValue = sender.value - 1;
    self.dySlider.maximumValue = sender.value - 1;
    self.dxValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.dxSlider.value, (int)self.dxSlider.maximumValue];
    self.dyValueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)self.dySlider.value, (int)self.dySlider.maximumValue];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
