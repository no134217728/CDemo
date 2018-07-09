//
//  APIRequest.h
//  CDemo
//
//  Created by Gelbhaubenkakadu on 2018/7/9.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequest : NSObject

- (void)requestDemoDataFromOpenDataServerLimit:(int)limit offset:(int)offset block:(void (^)(BOOL isSuccess, NSDictionary *result))callback;

@end
