//
//  SliderTableViewCell.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/4/16.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "SliderTableViewCell.h"

@implementation SliderTableViewCell

+ (SliderTableViewCell *)cell {
    NSArray *items = [[NSBundle mainBundle] loadNibNamed:@"SliderTableViewCell" owner:nil options:nil];
    return items.lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithAction:(SEL)action {
    self = [super init];
    self = [[NSBundle mainBundle] loadNibNamed:@"SliderTableViewCell" owner:self options:nil][0];
    [self.valueSlider addTarget:self action:action forControlEvents:UIControlEventValueChanged];
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier action:(SEL)action {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self.valueSlider addTarget:self action:action forControlEvents:UIControlEventValueChanged];
    return self;
}

- (IBAction)changeSlider:(UISlider *)sender {
    self.valueLabel.text = [NSString stringWithFormat:@"%d / %d", (int)sender.value, (int)self.valueSlider.maximumValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
