//
//  APIRequest.m
//  CDemo
//
//  Created by Gelbhaubenkakadu on 2018/7/9.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import "APIRequest.h"
#import "AFNetworking.h"

@implementation APIRequest

- (void)requestDemoDataFromOpenDataServerUrl:(NSString *)requestURL block:(void (^)(NSDictionary *result))callback {
    // http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:requestURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            // NSLog(@"%@ %@", response, responseObject);
            callback(responseObject);
        }
    }];
    [dataTask resume];
}

@end
