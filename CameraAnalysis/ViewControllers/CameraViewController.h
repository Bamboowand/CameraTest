//
//  CameraViewController.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/30.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../ProcessWrite/RosyWriterViewController.h"

#import "BaseFilterModel.h"
#import "SobelFilterModel.h"

@interface CameraViewController :RosyWriterViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *outputSwitch;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
- (instancetype)initWithHandler:(CVHandler *)handler;
- (instancetype)initWithFilterModel:(BaseFilterModel *)filterModel;
@end
