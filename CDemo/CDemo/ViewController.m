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

@interface ViewController () {
    APIRequest *api;
    
    __weak IBOutlet UITableView *mainTableView;
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resultArray = [[NSMutableArray alloc] init];
    _page = 0;
    
    // 弄掉 navbar 下的黑線
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    api = [[APIRequest alloc] init];
    [self requestFromAPIPage:_page];
}

- (void)requestFromAPIPage:(int)page {
    int offset = page * 30;
    
    __typeof__(self) __weak weakSelf = self;
    [api requestDemoDataFromOpenDataServerLimit:30 offset:offset block:^(BOOL isSuccess, NSDictionary *result) {
        if (isSuccess) {
            [weakSelf.resultArray addObjectsFromArray:(NSArray *)result[@"result"][@"results"]];
            NSLog(@"weakSelf.resultArray: %@", weakSelf.resultArray);
            weakSelf.page++;
            [self->mainTableView reloadData];
        } else {
            NSLog(@"Something wrong");
        }
    }];
}

#pragma mark - UITableViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cells"];
    
    cell.parkName.text = [NSString stringWithFormat:@"公園：%@", _resultArray[indexPath.row][@"ParkName"]];
    cell.parkDescription.text = [NSString stringWithFormat:@"%@", _resultArray[indexPath.row][@"Introduction"]];
//    cell.parkImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _resultArray[indexPath.row][@"Image"]]]]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
