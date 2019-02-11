//
//  ViewController.m
//  VisualResearcher
//
//  Created by ChenWei on 2019/2/11.
//  Copyright © 2019年 Jacob. All rights reserved.
//

#import "MasterViewController.h"
#import "CameraViewController.h"

@interface MasterViewController () {
    NSMutableArray *processorArray;
    NSArray *menuArray;
    NSMutableArray *processorNames;
    NSArray *aboutArray;

}

@end

@implementation MasterViewController

#pragma mark- View Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Visual Research";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    processorArray = [[NSMutableArray alloc] init];
    [processorArray addObject: [[VisualBasedProcessor alloc] init]];
    [processorArray addObject: [[SobelProcessor alloc] init]];
    
    processorNames = [[NSMutableArray alloc] init];
    for ( int i = 0; i < [processorArray count]; i++) {
        [processorNames addObject: [processorArray[i] getName]];
    }
    
    aboutArray = [NSArray arrayWithObjects:@"關於App", @"設定", nil];
    menuArray = [NSArray arrayWithObjects:processorNames, aboutArray, nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Visual Research";
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [super viewWillDisappear:animated];
}

#pragma mark- UITableViewController Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            CameraViewController *vc = [[CameraViewController alloc] initWithProcessor:processorArray[indexPath.row]];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            if ( indexPath.row == 0 ) {
                
            }
            else if ( indexPath.row == 1 ) {
                
            }
            else {
                
            }
            break;
        }
            
        default:
            break;
    }

}

#pragma mark- UITableViewController DataSourece
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [menuArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[menuArray objectAtIndex:section] count];
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
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( !cell )
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.textLabel.text = [[menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


@end
