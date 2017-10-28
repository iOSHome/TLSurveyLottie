//
//  TLAnimationTransitionViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/27.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLAnimationTransitionViewController.h"
#include "TLCloseAnimationViewController.h"

@interface TLAnimationTransitionViewController ()<UIViewControllerTransitioningDelegate>

@property (nonnull, strong) UIButton *transitionButton;
@property (nonnull, strong) UIButton *closeButton;

@end

@implementation TLAnimationTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.closeButton.backgroundColor = [UIColor colorWithRed:50.f/255.f
                                                       green:207.f/255.f
                                                        blue:193.f/255.f
                                                       alpha:1.f];
    self.closeButton.layer.cornerRadius = 7;
    
    [self.closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
    
    self.transitionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.transitionButton setTitle:@"Show Transition A" forState:UIControlStateNormal];
    [self.transitionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.transitionButton.backgroundColor = [UIColor colorWithRed:50.f/255.f
                                                   green:207.f/255.f
                                                    blue:193.f/255.f
                                                   alpha:1.f];
    self.transitionButton.layer.cornerRadius = 7;
    
    [self.transitionButton addTarget:self action:@selector(showTransitionAction) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor colorWithRed:122.f/255.f
                                                green:8.f/255.f
                                                 blue:81.f/255.f
                                                alpha:1.f];
    [self.view addSubview:self.transitionButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect b = self.view.bounds;
    CGSize buttonSize = [self.transitionButton sizeThatFits:b.size];
    buttonSize.width += 20;
    buttonSize.height += 20;
    self.transitionButton.bounds = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    self.transitionButton.center = self.view.center;
    
    
    CGSize closeSize = [self.closeButton sizeThatFits:b.size];
    closeSize.width += 20;
    closeSize.height += 20;
    
    self.closeButton.bounds = CGRectMake(0, 0, closeSize.width, closeSize.height);
    self.closeButton.center = CGPointMake(self.transitionButton.center.x, CGRectGetMaxY(b) - closeSize.height);
}

- (void)showTransitionAction {
    TLCloseAnimationViewController *vc = [[TLCloseAnimationViewController alloc] init];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void)closeAction {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -- View Controller Transitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition1"
                                                                                                              fromLayerNamed:@"outLayer"
                                                                                                                toLayerNamed:@"inLayer"
                                                                                                     applyAnimationTransform:NO];
    return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition2"
                                                                                                              fromLayerNamed:@"outLayer"
                                                                                                                toLayerNamed:@"inLayer"
                                                                                                     applyAnimationTransform:NO];
    return animationController;
}

@end
