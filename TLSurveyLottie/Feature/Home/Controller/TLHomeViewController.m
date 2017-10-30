//
//  TLHomeViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLHomeViewController.h"
#import "TLAppDelegate.h"
#import "TLZoomCycleImageView.h"

@interface TLHomeViewController ()

@property (nonatomic, strong) NSMutableArray *tableItems;

@property (nonatomic, strong) TLZoomCycleImageView *zoomCycleImageView;

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
    
    [self setupZoomCycleImageView];
    
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupZoomCycleImageView{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TLScreenWidth, TLZoomCycleImageViewHeight + 2 * TLPadding + 1)];
    headerView.backgroundColor = [UIColor clearColor];
    
    _zoomCycleImageView = [[TLZoomCycleImageView alloc] initWithFrame:CGRectMake(0, TLPadding, TLScreenWidth, TLZoomCycleImageViewHeight)];
    _zoomCycleImageView.picArray = @[[UIImage imageNamed:@"banner1"], [UIImage imageNamed:@"banner2"]];
    [headerView addSubview:_zoomCycleImageView];
    [_zoomCycleImageView setClickedCell:^(NSInteger index){
        NSLog(@"%ld",(long)index);
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(TLPadding, _zoomCycleImageView.bottom + TLPadding, TLScreenWidth, 1)];
    line.backgroundColor = [TLBlackColor colorWithAlphaComponent:0.05];
    [headerView addSubview:line];
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableItems[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"surveyLottleIdentifier";
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
            [self presentViewController:ctrl animated:YES completion:NULL];
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
