//
//  CameraViewController.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/30.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../ProcessWrite/RosyWriterViewController.h"
#import "../VisualProcessorModel/VisualBasedProcessor.h"
#import "../VisualProcessorModel/SobelProcessor.h"


@interface CameraViewController :RosyWriterViewController {
    VisualBasedProcessor *processor_;
}
- (instancetype)initWithProcessor:(VisualBasedProcessor *)processor;

@property (strong, nonatomic) IBOutlet UISegmentedControl *outputSwitch;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@end
