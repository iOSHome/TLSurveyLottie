//
//  TLCloseAnimationViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/27.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLCloseAnimationViewController.h"

@interface TLCloseAnimationViewController ()

@property (nonnull, strong) UIButton *closeButton;

@end

@implementation TLCloseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.closeButton setTitle:@"Show Transition B" forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.closeButton.backgroundColor = [UIColor colorWithRed:16.f/255.f
                                                   green:122.f/255.f
                                                    blue:134.f/255.f
                                                   alpha:1.f];
    self.closeButton.layer.cornerRadius = 7;
    
    [self.closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor colorWithRed:200.f/255.f
                                                green:66.f/255.f
                                                 blue:72.f/255.f
                                                alpha:1.f];
    [self.view addSubview:self.closeButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect b = self.view.bounds;
    CGSize buttonSize = [self.closeButton sizeThatFits:b.size];
    buttonSize.width += 20;
    buttonSize.height += 20;
    CGRect buttonRect;
    buttonRect.origin.x = b.origin.x + rintf(0.5f * (b.size.width - buttonSize.width));
    buttonRect.origin.y = b.origin.y + rintf(0.5f * (b.size.height - buttonSize.height));
    buttonRect.size = buttonSize;
    
    self.closeButton.frame = buttonRect;
}

- (void)closeAction {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
