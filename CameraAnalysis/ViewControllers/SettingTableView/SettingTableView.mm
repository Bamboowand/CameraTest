//
//  SettingTableView.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/4/16.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "SettingTableView.h"


@implementation SettingTableView
- (void)setupDefault {
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self registerNib:[UINib nibWithNibName:@"SliderTableViewCell" bundle:nil] forCellReuseIdentifier:@"SliderCell"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setupDefault];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame settingDictonary:(FilterSetArray *)array {
    self = [super initWithFrame:frame];
    _settingArray = array;
    
    [self setupDefault];
    return self;
}

#pragma mark- UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int size = (int)_settingArray->size();
    return size;
}

#pragma mark- UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SliderCell";
    UITableViewCell *cell;
    
    SettingUIType type = _settingArray->at(indexPath.row).type;
    if ( type == SettingUITypeSlider ) {
        SliderTableViewCell *sliderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if ( !sliderCell ) {
            sliderCell = [[SliderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier action:@selector(changeValueBySlider:)];

            sliderCell.tag = indexPath.row + 100;
            NSString *name = [NSString stringWithCString:_settingArray->at(indexPath.row).uiname encoding:[NSString defaultCStringEncoding]];
            sliderCell.titleLabel.text = name;
            sliderCell.valueSlider.maximumValue = _settingArray->at(indexPath.row).uivalue.sliderValue.max;
            sliderCell.valueSlider.minimumValue = _settingArray->at(indexPath.row).uivalue.sliderValue.min;
            sliderCell.valueSlider.value = _settingArray->at(indexPath.row).uivalue.sliderValue.value;
        }
        
        return sliderCell;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if ( !cell ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    return cell;
}

- (IBAction)changeValueBySlider:(UISlider *)sender {
    int index = (int)sender.tag - 100;
    if ( _settingArray->at(index).uivalue.sliderValue.oddValue ) {
        if ( (int)sender.value % 2 == 0 )
            sender.value = (int)sender.value + 1;
    }
    else {
        sender.value = (int)sender.value;
    }
    

    _settingArray->at(index).uivalue.sliderValue.value = sender.value;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
