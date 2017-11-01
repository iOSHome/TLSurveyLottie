//
//  TLAnimationExplorerViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/27.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLAnimationExplorerViewController.h"
#import "TLJSONExplorerViewController.h"
#import "TLQRScannerViewController.h"

typedef enum : NSUInteger {
    TLViewBackgroundColorWhite,
    TLViewBackgroundColorBlack,
    TLViewBackgroundColorGreen,
    TLViewBackgroundColorNone
} TLViewBackgroundColor;

@interface TLAnimationExplorerViewController ()

@property (nonatomic, assign) TLViewBackgroundColor currentBGColor;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) LOTAnimationView *laAnimation;

@end

@implementation TLAnimationExplorerViewController

- (void)setCurrentBGColor:(TLViewBackgroundColor)currentBGColor {
    _currentBGColor = currentBGColor;
    switch (currentBGColor) {
        case TLViewBackgroundColorWhite:
            self.view.backgroundColor = [UIColor whiteColor];
            break;
        case TLViewBackgroundColorBlack:
            self.view.backgroundColor = [UIColor blackColor];
            break;
        case TLViewBackgroundColorGreen:
            self.view.backgroundColor = [UIColor colorWithRed:50.f/255.f
                                                        green:207.f/255.f
                                                         blue:193.f/255.f
                                                        alpha:1.f];
            break;
        case TLViewBackgroundColorNone:
            self.view.backgroundColor = nil;
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentBGColor = TLViewBackgroundColorWhite;
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *open = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(_open:)];
    UIBarButtonItem *flx1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *openWeb = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(_showURLInput)];
    UIBarButtonItem *flx2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *play = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(_play:)];
    UIBarButtonItem *flx3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *loop = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(_loop:)];
    UIBarButtonItem *flx4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *zoom = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_setZoom:)];
    UIBarButtonItem *flx5 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bgcolor = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(_setBGColor:)];
    UIBarButtonItem *flx6 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(_close:)];
    self.toolbar.items = @[open, flx1, openWeb, flx2, loop, flx3, play, flx4, zoom, flx5, bgcolor, flx6, close];
    [self.view addSubview:self.toolbar];
    [self resetAllButtons];
    @weakify(self);
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(44));
        make.bottom.equalTo(self.view);
    }];
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectZero];
    [self.slider addTarget:self action:@selector(_sliderChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    [self.view addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view).offset(10.f);
        make.right.equalTo(self.view).offset(-10.f);
        make.height.equalTo(@(12.f));
        make.bottom.equalTo(self.toolbar.mas_top).offset(-20.f);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetAllButtons {
    self.slider.value = 0;
    for (UIBarButtonItem *button in self.toolbar.items) {
        [self resetButton:button highlighted:NO];
    }
}

- (void)resetButton:(UIBarButtonItem *)button highlighted:(BOOL)highlighted {
    button.tintColor = highlighted ? [UIColor redColor] : [UIColor colorWithRed:50.f/255.f
                                                                          green:207.f/255.f
                                                                           blue:193.f/255.f
                                                                          alpha:1.f];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.laAnimation.frame = CGRectMake(0, 0, self.view.bounds.size.width, CGRectGetMinY(self.slider.frame));
}

#pragma mark - Action

- (void)_sliderChanged:(UISlider *)slider {
    self.laAnimation.animationProgress = slider.value;
}

- (void)_open:(UIBarButtonItem *)button {
    [self _showJSONExplorer];
}

- (void)_setZoom:(UIBarButtonItem *)button {
    switch (self.laAnimation.contentMode) {
        case UIViewContentModeScaleAspectFit: {
            self.laAnimation.contentMode = UIViewContentModeScaleAspectFill;
            [self showMessage:@"Aspect Fill"];
        }  break;
        case UIViewContentModeScaleAspectFill:{
            self.laAnimation.contentMode = UIViewContentModeScaleToFill;
            [self showMessage:@"Scale Fill"];
        }
            break;
        case UIViewContentModeScaleToFill: {
            self.laAnimation.contentMode = UIViewContentModeScaleAspectFit;
            [self showMessage:@"Aspect Fit"];
        }
            break;
        default:
            break;
    }
}

- (void)_setBGColor:(UIBarButtonItem *)button {
    TLViewBackgroundColor current = self.currentBGColor;
    current += 1;
    if (current == TLViewBackgroundColorNone) {
        current = TLViewBackgroundColorWhite;
    }
    self.currentBGColor = current;
}

- (void)_showURLInput {
    TLQRScannerViewController *qrVC = [[TLQRScannerViewController alloc] init];
    [qrVC setCompletionBlock:^(NSString *selectedAnimation) {
        if (selectedAnimation) {
            [self _loadAnimationFromURLString:selectedAnimation];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:qrVC];
    [self presentViewController:nav animated:YES completion:NULL];
    return;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Load From URL"
                                                                   message:NULL
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter URL";
    }];
    
    UIAlertAction *load = [UIAlertAction actionWithTitle:@"Load" style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action) {
                                                     [self _loadAnimationFromURLString:alert.textFields.firstObject.text];
                                                 }];
    
    [alert addAction:load];
    
    UIAlertAction *close = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * action) {
                                                      
                                                  }];
    
    [alert addAction:close];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)_showJSONExplorer {
    TLJSONExplorerViewController *vc = [[TLJSONExplorerViewController alloc] init];
    [vc setCompletionBlock:^(NSString *selectedAnimation) {
        if (selectedAnimation) {
            [self _loadAnimationNamed:selectedAnimation];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navController animated:YES completion:NULL];
}

- (void)_loadAnimationFromURLString:(NSString *)URL {
    [self.laAnimation removeFromSuperview];
    self.laAnimation = nil;
    [self resetAllButtons];
    
    self.laAnimation = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:URL]];
    self.laAnimation.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.laAnimation];
    [self.view setNeedsLayout];
}

- (void)_loadAnimationNamed:(NSString *)named {
    [self.laAnimation removeFromSuperview];
    self.laAnimation = nil;
    [self resetAllButtons];
    
    self.laAnimation = [LOTAnimationView animationNamed:named];
    self.laAnimation.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.laAnimation];
    [self.view setNeedsLayout];
}

- (void)_rewind:(UIBarButtonItem *)button {
    self.laAnimation.animationProgress = 0;
}

- (void)_play:(UIBarButtonItem *)button {
    if (self.laAnimation.isAnimationPlaying) {
        [self resetButton:button highlighted:NO];
        [self.laAnimation pause];
    } else {
        
        CADisplayLink *displayLink =[CADisplayLink displayLinkWithTarget:self selector:@selector(_updateSlider)] ;
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [self resetButton:button highlighted:YES];
        [self.laAnimation playWithCompletion:^(BOOL animationFinished) {
            [displayLink invalidate];
            [self resetButton:button highlighted:NO];
        }];
    }
}

- (void)_updateSlider {
    self.slider.value = self.laAnimation.animationProgress;
}

- (void)_loop:(UIBarButtonItem *)button {
    self.laAnimation.loopAnimation = !self.laAnimation.loopAnimation;
    [self resetButton:button highlighted:self.laAnimation.loopAnimation];
    [self showMessage:self.laAnimation.loopAnimation ? @"Loop Enabled" : @"Loop Disabled"];
}

- (void)_close:(UIBarButtonItem *)button {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)showMessage:(NSString *)message {
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = message;
    
    CGSize messageSize = [messageLabel sizeThatFits:self.view.bounds.size];
    messageSize.width += 14;
    messageSize.height += 14;
    messageLabel.frame = CGRectMake(10, 30, messageSize.width, messageSize.height);
    messageLabel.alpha = 0;
    [self.view addSubview:messageLabel];
    
    [UIView animateWithDuration:0.3 animations:^{
        messageLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            messageLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [messageLabel removeFromSuperview];
        }];
    }];
}

@end
