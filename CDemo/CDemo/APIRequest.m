//
//  APIRequest.m
//  CDemo
//
//  Created by Gelbhaubenkakadu on 2018/7/9.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import "APIRequest.h"
#import "APIModel.h"
#import "AFNetworking.h"

@implementation APIRequest

- (void)requestDemoDataFromOpenDataServerLimit:(int)limit offset:(int)offset block:(void (^)(BOOL isSuccess, NSDictionary *result))callback {
    // http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812
    
    NSString *paraLimit = [NSString stringWithFormat:@"%d", limit];
    NSString *paraOffset = [NSString stringWithFormat:@"%d", offset];
    
    NSString *URLString = @"http://data.taipei/opendata/datalist/apiAccess";
    NSDictionary *parameters = @{@"scope": @"resourceAquire", @"rid": @"bf073841-c734-49bf-a97f-3757a6013812", @"limit": paraLimit, @"offset": paraOffset};
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            callback(NO, nil);
        } else {
            callback(YES, responseObject);
        }
    }];
    
    [dataTask resume];
}

@end
