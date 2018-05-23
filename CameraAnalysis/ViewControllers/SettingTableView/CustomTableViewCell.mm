//
//  CustomTableViewCell.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/17.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

+ (CustomTableViewCell *)cell {
    NSArray *items = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:nil options:nil];
    return items.lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
