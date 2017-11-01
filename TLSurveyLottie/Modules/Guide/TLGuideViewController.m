//
//  TLGuideViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLGuideViewController.h"
#import "TLHomeViewController.h"
#import "TLAdvancedViewController.h"
#import "TLProfileViewController.h"

@interface TLGuideViewController ()

@property (nonatomic, strong) UIView *launchMask;
@property (nonatomic, strong) LOTAnimationView *launchAnimation;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *page1;
@property (nonatomic, strong) LOTAnimationView *animation1;
@property (nonatomic, strong) UIImageView *page2;
@property (nonatomic, strong) LOTAnimationView *animation2;
@property (nonatomic, strong) UIImageView *page3;
@property (nonatomic, strong) LOTAnimationView *animation3;
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation TLGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubViews];
    
    [self setupLaunchMask];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_launchMask && _launchAnimation) {
        @weakify(self);
        [_launchAnimation playWithCompletion:^(BOOL animationFinished) {
            @strongify(self);
            [UIView animateWithDuration:0.3 animations:^{
                self.launchMask.alpha = 0;
            } completion:^(BOOL finished) {
                [self.launchAnimation removeFromSuperview];
                self.launchAnimation = nil;
                [self.launchMask removeFromSuperview];
                self.launchMask = nil;
            }];
        }];
    }
    
    [_animation1 play];
    [_animation2 play];
    [_animation3 play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)setSubViews{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(TLScreenWidth * 3, TLScreenHeight);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
    _page1 = [UIImageView imageViewWithFrame:self.view.bounds image:[UIImage imageNamed:@"page1"]];
    
    [_scrollView addSubview:_page1];
    
    _animation1 = [LOTAnimationView animationNamed:@"GuidePage1"];
    _animation1.cacheEnable = NO;
    _animation1.frame = CGRectMake(TLPadding, TLScreenHeight - 200 - 4 * TLPadding, 200, 300);
    _animation1.contentMode = UIViewContentModeScaleToFill;
    _animation1.animationSpeed = 1.0;
    _animation1.loopAnimation = YES;
    
    [_scrollView addSubview:_animation1];
    
    
    _page2 = [UIImageView imageViewWithFrame:CGRectMake(TLScreenWidth, 0, TLScreenWidth, TLScreenHeight) image:[UIImage imageNamed:@"page2"]];
    
    [_scrollView addSubview:_page2];
    
    _animation2 = [LOTAnimationView animationNamed:@"GuidePage2"];
    _animation2.cacheEnable = NO;
    _animation2.frame = CGRectMake(TLPadding + TLScreenWidth, TLScreenHeight - 200 - 4 * TLPadding, 200, 300);
    _animation2.contentMode = UIViewContentModeScaleToFill;
    _animation2.animationSpeed = 1.0;
    _animation2.loopAnimation = YES;
    
    [_scrollView addSubview:_animation2];
    
    
    _page3 = [UIImageView imageViewWithFrame:CGRectMake(TLScreenWidth * 2, 0, TLScreenWidth, TLScreenHeight) image:[UIImage imageNamed:@"page3"]];
    
    [_scrollView addSubview:_page3];
    
    _animation3 = [LOTAnimationView animationNamed:@"GuidePage3"];
    _animation3.cacheEnable = NO;
    _animation3.frame = CGRectMake(TLPadding  + TLScreenWidth * 2, TLScreenHeight - 200 - 4 * TLPadding, 200, 300);
    _animation3.contentMode = UIViewContentModeScaleToFill;
    _animation3.animationSpeed = 1.0;
    _animation3.loopAnimation = YES;
    
    [_scrollView addSubview:_animation3];
    
    CGFloat btnWidth = TLWidth(132.5);
    CGFloat btnHeight = TLHeight(35.5);
    _startBtn = [UIButton buttonWithFrame:CGRectMake((TLScreenWidth - btnWidth) / 2 + 2 * TLScreenWidth, TLScreenHeight - btnHeight - 2 * TLPadding, btnWidth, btnHeight) title:nil color:nil font:nil backgroundImage:[UIImage imageNamed:@"startImg"] target:self action:@selector(loadRootViewController)];
    
    [_scrollView addSubview:_startBtn];
}

- (void)setupLaunchMask{
    _launchMask = [[UIView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_launchMask];
    
    _launchAnimation = [LOTAnimationView animationNamed:@"Launch"];
    _launchAnimation.cacheEnable = NO;
    _launchAnimation.frame = self.view.bounds;
    _launchAnimation.contentMode = UIViewContentModeScaleToFill;
    _launchAnimation.animationSpeed = 1.2;
    
    [_launchMask addSubview:_launchAnimation];
}

- (void)loadRootViewController{
    //初始化
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.tabBar.tintColor = TLCommonTextColor;
    
    TLHomeViewController *homeVC = [[TLHomeViewController alloc] init];
    TLNavigationController *homeNaviVC = [[TLNavigationController alloc] initWithRootViewController:homeVC];
    homeNaviVC.tabBarItem.title = @"首页";
    homeNaviVC.tabBarItem.image = [UIImage renderingModeOriginalImageNamed:@"home"];
    homeNaviVC.tabBarItem.selectedImage = [UIImage renderingModeOriginalImageNamed:@"homeSel"];
    
    TLAdvancedViewController *advancedVC = [[TLAdvancedViewController alloc] init];
    TLNavigationController *advancedNaviVC = [[TLNavigationController alloc] initWithRootViewController:advancedVC];
    advancedNaviVC.tabBarItem.title = @"高级";
    advancedNaviVC.tabBarItem.image = [UIImage renderingModeOriginalImageNamed:@"relation"];
    advancedNaviVC.tabBarItem.selectedImage = [UIImage renderingModeOriginalImageNamed:@"relationSel"];
    
    TLProfileViewController *meVC = [[TLProfileViewController alloc] init];
    TLNavigationController *meNaviVC = [[TLNavigationController alloc] initWithRootViewController:meVC];
    meNaviVC.tabBarItem.title = @"我";
    meNaviVC.tabBarItem.image = [UIImage renderingModeOriginalImageNamed:@"me"];
    meNaviVC.tabBarItem.selectedImage = [UIImage renderingModeOriginalImageNamed:@"meSel"];
    
    tabBarVC.viewControllers = @[homeNaviVC, advancedNaviVC, meNaviVC];
    
    TLKeyWindow.rootViewController = tabBarVC;
}

@end
