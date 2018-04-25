//
//  SliderTableViewCell.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/4/16.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UISlider *valueSlider;

- (instancetype)initWithAction:(SEL)action;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier action:(SEL)action;

+ (SliderTableViewCell *)cell;

@end
