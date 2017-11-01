//
//  TLHomeViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLHomeViewController.h"
#import "TLAppDelegate.h"
#import "TLAnimationRefreshHeader.h"
#import "TLAnimationRefreshFooter.h"


@interface TLHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableItems;

@end

@implementation TLHomeViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Lottle";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.tableItems = @[].mutableCopy;
    
    NSArray *item = @[
                      @{@"name" : @"Animated Explorer",
                        @"vc" : @"TLAnimationExplorerViewController"},
                      @{@"name" : @"Animated Keyboard",
                        @"vc" : @"TLAnimationKeyboardViewController"},
                      @{@"name" : @"Animated Transitions",
                        @"vc" : @"TLAnimationTransitionViewController"},
                      @{@"name" : @"Animated UIControls",
                        @"vc" : @"TLAnimationUIControlsViewController"}
                      ];
    
    [self.tableItems addObject:item];
    
    
    @weakify(self);
    TLAnimationRefreshHeader *refreshHeader = [TLAnimationRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
    [self.tableView setMj_header:refreshHeader];
    
    TLAnimationRefreshFooter *refreshFooter = [TLAnimationRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadMoreData];
    }];
    [self.tableView setMj_footer:refreshFooter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
- (void)loadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableItems[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"surveyGrowingIOIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *itemArray = self.tableItems[indexPath.section];
    cell.textLabel.text = itemArray[indexPath.row][@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *itemArray = self.tableItems[indexPath.section];
    
    NSString *className = itemArray[indexPath.row][@"vc"];
    Class vcClass = NSClassFromString(className);
    if (vcClass) {
        UIViewController *ctrl = [[vcClass alloc] init];
        ctrl.title = itemArray[indexPath.row][@"name"];
        
        if (indexPath.section == 0) {
            //由于需要执行动画，必须保证在主线程执行
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:ctrl animated:YES completion:nil];
            });
        } else {
            TLAppDelegate *appDelegate = (TLAppDelegate *) [UIApplication sharedApplication].delegate;
            UINavigationController *navigationController = (UINavigationController *) appDelegate.viewController;
            [navigationController pushViewController:ctrl animated:YES];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.backgroundColor = [UIColor whiteColor];
    lblTitle.textColor = [UIColor grayColor];
    
    switch (section) {
        case 0:
        {
            lblTitle.text = @"调研清单";
            return lblTitle;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

@end
