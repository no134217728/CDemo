//
//  APIModel.m
//  CDemo
//
//  Created by Wei Jen Wang on 2018/7/10.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import "APIModel.h"

@implementation APIModel

- (void)resultFromDict:(NSDictionary *)dict {
    parkName = dict[@"ParkName"];
    parkDescription = dict[@"Introduction"];
    parkImageUrl = dict[@"Image"];
//    parkImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"Image"]]]]];
}

@end
