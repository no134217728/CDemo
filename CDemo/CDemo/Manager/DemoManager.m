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
NSMutableArray *demoArray;

@implementation DemoManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        api = [[APIRequest alloc] init];
        demoArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)requestFromAPIPage:(int)page {
    int offset = page * 30;
    
    [api requestDemoDataFromOpenDataServerLimit:30 offset:offset block:^(BOOL isSuccess, NSDictionary *result) {
        if (isSuccess) {
            NSArray *aryFromAPI = (NSArray *)result[@"result"][@"results"];
            if (aryFromAPI.count == 0) {
                   NSString *jsonStringFile = [[NSBundle mainBundle] pathForResource:@"StubParks" ofType:@"json"];
                   if (jsonStringFile) {
                       NSData *jsonData = [NSData dataWithContentsOfFile:jsonStringFile];
                       NSDictionary *stubData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
                       aryFromAPI = stubData[@"result"][@"results"];
                   }
            }
            
            for (NSDictionary *dic in aryFromAPI) {
                APIModel *model = [[APIModel alloc] init];
                [model resultFromDict:dic];
                [demoArray addObject:model];
            }
            
            [self.delegate finishAPIRequestResult];
        } else {
            NSLog(@"Something wrong");
        }
    }];
}

- (NSArray *)fetchAPIData {
    return demoArray;
}

@end
