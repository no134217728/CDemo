//
//  DemoManager.h
//  CDemo
//
//  Created by Wei Jen Wang on 2018/7/10.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol DemoManagerDelegate <NSObject>
//- (void)finishAPIRequestResult:(NSArray *)resultArray;
//@end

@interface DemoManager : NSObject
- (void)requestFromAPIPage:(int)page;

//@property (nonatomic, weak) id<DemoManagerDelegate> delegate;

@end


