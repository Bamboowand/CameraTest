//
//  SettingTableView.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/4/16.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderTableViewCell.h"

typedef enum SettingStyle1{
    kFilterStyle1,
    kFilterStyle2,
    kNone
}SettingStyle1;

@interface SettingTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
{
    SettingStyle1 _style;
}

- (instancetype)initWithFrame:(CGRect)frame Style:(SettingStyle1)style;


@end
