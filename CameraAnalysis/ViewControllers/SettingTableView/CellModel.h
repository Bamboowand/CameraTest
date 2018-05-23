//
//  CellModel.h
//  CameraAnalysis
//
//  Created by ChenWei on 2018/5/18.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellModel : NSObject

@property (nonatomic)NSString *title;
@property (nonatomic)NSString *value;
@property (nonatomic)UIControl *control;

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value control:(UIControl *)control;

@end
