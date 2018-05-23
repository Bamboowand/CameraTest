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
    [self registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
}

#pragma mark- init
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

- (instancetype)initWithFrame:(CGRect)frame settingUIArray:(NSArray *)array {
    self = [super initWithFrame:frame];
    _settingUIArray = array;
    [self setupDefault];
    [self addKVO];
    return self;
}

- (void)releaseCell {
    [self removeKVO];
}
#pragma mark- UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    int size = (int)_settingArray->size();
//    return size;
    return _settingUIArray.count;
}

#pragma mark- UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CustomCell";
    CustomTableViewCell *custom = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( !custom ) {
        custom = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CellModel *cellMode = _settingUIArray[indexPath.row];
    custom.cellTitle.text = cellMode.title;
    custom.cellValue.text = cellMode.value;
    [custom.cellView addSubview:cellMode.control];
//    [custom.cellView addSubview:_settingUIArray[indexPath.row]];
    return custom;
}

#pragma mark- Notification
- (void)addKVO {
    for ( CellModel *cell in _settingUIArray ) {
        [cell addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)removeKVO {
    for ( CellModel *cell in _settingUIArray ) {
        [cell removeObserver:self forKeyPath:@"value"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
