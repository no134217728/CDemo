//
//  ViewController.m
//  CDemo
//
//  Created by Gelbhaubenkakadu on 2018/7/9.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import "ViewController.h"
#import "APIRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 弄掉 navbar 下的黑線
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    APIRequest *api = [[APIRequest alloc] init];
    [api requestDemoDataFromOpenDataServerUrl:@"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812" block:^(NSDictionary *result) {
        NSLog(@"%@", result);
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cells"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
