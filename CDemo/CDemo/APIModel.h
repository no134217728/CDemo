//
//  APIModel.h
//  CDemo
//
//  Created by Wei Jen Wang on 2018/7/10.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APIModel : NSObject {
    NSString *parkName;
    NSString *parkDescription;
    NSString *parkImageUrl;
    UIImage *parkImage;
}

- (void)resultFromDict:(NSDictionary *)dict;
- (NSString *)obtainParkName;
- (NSString *)obtainParkDescription;
- (NSString *)obtainParkImageURL;
- (UIImage *)obtainParkImage;

@end
