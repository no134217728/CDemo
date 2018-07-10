//
//  DemoManager.m
//  CDemo
//
//  Created by Wei Jen Wang on 2018/7/10.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import "DemoManager.h"
#import "APIModel.h"
#import "APIRequest.h"

APIRequest *api;
APIModel *model;

@implementation DemoManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        api = [[APIRequest alloc] init];
        model = [[APIModel alloc] init];
    }
    return self;
}

- (void)requestFromAPIPage:(int)page {
    int offset = page * 30;
    
    [api requestDemoDataFromOpenDataServerLimit:30 offset:offset block:^(BOOL isSuccess, NSDictionary *result) {
        if (isSuccess) {
            [model resultFromDict:result];
//            [self->_delegate finishAPIRequestResult:(NSArray *)result[@"result"][@"results"]];
        } else {
            NSLog(@"Something wrong");
        }
    }];
}

@end
