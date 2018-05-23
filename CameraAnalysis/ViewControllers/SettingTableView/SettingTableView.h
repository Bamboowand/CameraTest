//
//  SettingTableView.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/4/16.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#include "CameraParameter.hpp"
#import <UIKit/UIKit.h>
#import "SliderTableViewCell.h"
#import "CustomTableViewCell.h"
#import "CellModel.h"



@interface SettingTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
{
    FilterSetArray *_settingArray;
    NSMutableArray *_titleArr;
    NSArray *_settingUIArray;
}

- (instancetype)initWithFrame:(CGRect)frame settingDictonary:(FilterSetArray *)array;
- (instancetype)initWithFrame:(CGRect)frame settingUIArray:(NSArray *)array;

- (void)releaseCell;
@end
