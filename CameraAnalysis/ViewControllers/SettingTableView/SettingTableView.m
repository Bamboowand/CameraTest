//
//  SettingTableView.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/4/16.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "SettingTableView.h"

@implementation SettingTableView

- (instancetype)initWithFrame:(CGRect)frame Style:(SettingStyle1)style {
    self = [super initWithFrame:frame];
    _style = style;
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self registerNib:[UINib nibWithNibName:@"SliderTableViewCell" bundle:nil] forCellReuseIdentifier:@"SliderCell"];
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (SliderTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SliderCell";
    SliderTableViewCell *sliderCell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if ( !sliderCell ) {
        sliderCell = [[SliderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    SliderTableViewCell *cell = [SliderTableViewCell cell];
    switch ( indexPath.row) {
        case 0:
        {
            sliderCell.titleLabel.text = @"KSize";
            sliderCell.valueSlider.maximumValue = 100.0f;
//            [sliderCell.valueSlider addTarget:sliderCell action:@selector(changeValueBySlider:) forControlEvents:UIControlEventValueChanged];
            
            break;
        }
        case 1:
        {
            
            break;
        }
        case 2:
        {
            
            break;
        }
        case 3:
        {
            
            break;
        }
        default:
            break;
    }

    
    return sliderCell;
}

- (IBAction)changeValueBySlider:(UISlider *)sender {
    sender.value = (int)sender;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
