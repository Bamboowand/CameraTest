//
//  CustomTableViewCell.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/17.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellValue;
@property (weak, nonatomic) IBOutlet UIView *cellView;



+ (CustomTableViewCell *)cell;
@end
