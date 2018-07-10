//
//  ViewController.h
//  CDemo
//
//  Created by Gelbhaubenkakadu on 2018/7/9.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoManager.h"

@interface ViewController : UIViewController <UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource, DemoManagerDelegate>

@property NSArray *resultArray;
@property int page;

@end

