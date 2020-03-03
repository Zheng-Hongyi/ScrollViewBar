//
//  ViewController.m
//  EWScrollViewVerticalBar
//
//  Created by Yi on 2020/3/2.
//  Copyright © 2020 Yi. All rights reserved.
//

#import "ViewController.h"
#import <EWScrollViewVerticalBar/EWScrollViewVerticalBar.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) EWScrollViewVerticalBar *progressBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadBar];
}

- (void)loadBar {
    self.progressBar = [[EWScrollViewVerticalBar alloc]
                        initWithFrame:CGRectMake(0, self.tableView.frame.origin.y, 10, self.tableView.frame.size.height)
                        backgroundColor:[UIColor clearColor]
                        progressColor:[UIColor redColor]];
    [self.view addSubview:self.progressBar];
    [self.progressBar bindScrollView:self.tableView];
}

#pragma mark - Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.progressBar updateScrollState:kScrollViewState_Start];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self.progressBar updateScrollState:kScrollViewState_End];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.progressBar updateScrollState:kScrollViewState_End];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCell"];
    return cell;
}

@end
