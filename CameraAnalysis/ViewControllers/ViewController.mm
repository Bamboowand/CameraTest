//
//  ViewController.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/22.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "ViewController.h"
#import "VideoViewController.h"
#import "CameraViewController.h"
#import "../ProcessWrite/RosyWriterViewController.h"
#import "SettingViewController.h"
#import "AboutViewController.h"

#import "BaseFilterModel.h"
#import "SobelFilterModel.h"
@interface ViewController (){
    NSMutableArray *processArray;
    NSArray *aboutArray;
    NSArray *totalArray;
    std::vector<CVHandler*> handlers;
    NSArray *_filterModels;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"viewDidLoad");
    self.title = @"Camera analysis";
    processArray = [[NSMutableArray alloc] init];
    handlers.push_back(new CVHandler);
    handlers.push_back(new ThresholdHandler);
    handlers.push_back(new GaussianBlurHandler);
    handlers.push_back(new SobleHandler);
    handlers.push_back(new CannyHandler);
//    handlers.push_back(new CameraCalibrationHandler);
//    for (int i = 0; i < handlers.size(); i++) {
//        [processArray addObject:[NSString stringWithUTF8String:handlers[i]->get_name()]];
//    }
    
    _filterModels = [NSArray arrayWithObjects:[BaseFilterModel new],
                     [SobelFilterModel new],
                     [CannyFilterModel new], nil];
    for ( int i = 0; i < _filterModels.count; i++ ) {
        BaseFilterModel *model = [_filterModels objectAtIndex:i];
        [processArray addObject:[model getFilterName]];
    }

    aboutArray = [NSArray arrayWithObjects:@"關於App", @"設定", nil];
    totalArray = [NSArray arrayWithObjects:processArray, aboutArray, nil];

    


    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    self.title = @"Camera analysis";
    
}

- (void)viewWillDisappear:(BOOL)animated {
//    NSLog(@"viewWillDisappear");
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    for (int i = 0; i < handlers.size(); i++) {
        delete handlers[i];
    }
    handlers.clear();
}

- (BOOL)shouldAutorotate {
    [super shouldAutorotate];
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    [super supportedInterfaceOrientations];
    return UIInterfaceOrientationPortrait;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
//    NSString *name = [processArray objectAtIndex:path.row];
//    [segue.destinationViewController setValue:name forKey:@"processName"];
//}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
//            CameraViewController *camera = [[CameraViewController alloc] initWithHandler:handlers[indexPath.row]];
            CameraViewController *camera = [[CameraViewController alloc] initWithFilterModel:_filterModels[indexPath.row]];
            [self.navigationController pushViewController:camera animated:YES];
            break;
        }
        case 1:
        {
            if ( indexPath.row == 0 ) {
                AboutViewController *vc = [[AboutViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ( indexPath.row == 1 ) {
                SettingViewController *vc = [[SettingViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else {
                
            }
            break;
        }
            
        default:
            break;
    }
    
//    if ( indexPath.row == 0 ) {
////        RosyWriterViewController *camera = [[RosyWriterViewController alloc] initWithHandler:handlers[1]];
//        CameraViewController *camera = [[CameraViewController alloc] initWithHandler:handlers[1]];
//        [self.navigationController pushViewController:camera animated:YES];
//    }
//    else {
//        VideoViewController *viewController = [[VideoViewController alloc] initWithHandler:handlers[indexPath.row]];
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
}

#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [totalArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[totalArray objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return @"Filter";
            break;
        }
        case 1:
        {
            return @"Other";
            break;
        }
        default:
        {
            return @"";
            break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    cell.textLabel.text = [processArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [[totalArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}




@end
