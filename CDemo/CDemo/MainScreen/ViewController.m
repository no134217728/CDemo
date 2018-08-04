//
//  ViewController.m
//  CDemo
//
//  Created by Gelbhaubenkakadu on 2018/7/9.
//  Copyright © 2018年 Apacer. All rights reserved.
//

#import "ViewController.h"
#import "MainTableViewCell.h"
#import "APIRequest.h"
#import "DemoManager.h"
#import "APIModel.h"

@interface ViewController () {
    double y;
    DemoManager *manager;
    __weak IBOutlet UITableView *mainTableView;
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [[DemoManager alloc] init];
    manager.delegate = self;
    
    _resultArray = [[NSMutableArray alloc] init];
    _page = 0;
    
    // 弄掉 navbar 下的黑線
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [manager requestFromAPIPage:_page];
}

#pragma mark - DemoManagerDelegate
- (void)finishAPIRequestResult {
    _page++;
    _resultArray = [manager fetchAPIData];
    [mainTableView reloadData];
}

#pragma mark - UITableViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cells"];
    
    APIModel *model = _resultArray[indexPath.row];
    cell.parkName.text = [NSString stringWithFormat:@"%@ %ld", [model obtainParkName], indexPath.row];
    cell.parkDescription.text = [model obtainParkDescription];
    cell.parkImage.image = nil;
    
    NSString *imageURL = [model obtainParkImageURL];
    dispatch_queue_t queue = dispatch_queue_create("downloadFromUrl", nil);
    dispatch_async(queue, ^{
        if (!model.parkImage) {
            model.parkImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", imageURL]]]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.parkImage.image = [model obtainParkImage];
        });
    });

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= _resultArray.count - 1) {
        NSLog(@"%d", _page);
        [manager requestFromAPIPage:_page];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 0) {
        if (y < 117) {
            y = y + scrollView.contentOffset.y;
            scrollView.contentOffset = CGPointZero;
            _constraintTableViewToButtons.constant = MAX(-117, -y);
        } else {
            y = 117;
        }
    } else {
        if (y > 0) {
            y = y + scrollView.contentOffset.y;
            scrollView.contentOffset = CGPointZero;
            _constraintTableViewToButtons.constant = MAX(-117, -y);
        } else {
            y = 0;
        }
    }

    NSLog(@"%f", y);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (y < 117 && y > 59) {
        [UIView animateWithDuration:0.2 animations:^{
            self->_constraintTableViewToButtons.constant = -117;
            [self.view layoutIfNeeded];
        }];
        
        y = 117;
    } else if (y > 0 && y < 59) {
        [UIView animateWithDuration:0.2 animations:^{
            self->_constraintTableViewToButtons.constant = 0;
            [self.view layoutIfNeeded];
        }];
        
        y = 0;
    }
}

@end
