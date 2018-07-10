//
//  ViewController.m
//  CDemo
//
//  Created by Gelbhaubenkakadu on 2018/7/9.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import "ViewController.h"
#import "MainTableViewCell.h"
#import "APIRequest.h"
#import "DemoManager.h"

@interface ViewController () {
    DemoManager *manager;
    __weak IBOutlet UITableView *mainTableView;
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [[DemoManager alloc] init];
    
    _resultArray = [[NSMutableArray alloc] init];
    _page = 0;
    
    // 弄掉 navbar 下的黑線
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [manager requestFromAPIPage:_page];
}

//#pragma mark - DemoManagerDelegate
//- (void)finishAPIRequestResult:(NSArray *)resultArray {
//    [_resultArray addObjectsFromArray:resultArray];
//    [mainTableView reloadData];
//}

#pragma mark - UITableViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cells"];
    
    cell.parkName.text = [NSString stringWithFormat:@"公園：%@ %ld", _resultArray[indexPath.row][@"ParkName"], (long)indexPath.row];
    cell.parkDescription.text = [NSString stringWithFormat:@"%@", _resultArray[indexPath.row][@"Introduction"]];
//    cell.parkImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _resultArray[indexPath.row][@"Image"]]]]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= _resultArray.count - 1) {
        [manager requestFromAPIPage:_page];
    }
}

@end
