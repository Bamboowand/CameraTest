//
//  CellModel.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/18.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value control:(UIControl *)control {
    if ( !self ) {
        self = [super init];
    }
    self.title = title;
    self.value = value;
    self.control = control;
    return self;
}

@end
