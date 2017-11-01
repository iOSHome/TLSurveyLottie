//
//  TLAnimationUIButtonViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/11/1.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLAnimationUIButtonViewController.h"

@interface TLAnimationUIButtonViewController ()

@property (nonatomic,strong) LOTAnimationView *switchButton;
@property (nonatomic,assign) BOOL isOff;

@property (nonatomic,strong) LOTAnimationView *editButton;
@property (nonatomic,assign) BOOL isEditing;

@property (nonatomic,strong) LOTAnimationView *playButton;
@property (nonatomic,assign) BOOL isPlaying;

@property (nonatomic, strong) UIButton *giftButton;
@end

@implementation TLAnimationUIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"按钮动画";
    [self initSwitchButton];
    [self initEditButton];
    [self initPlayButton];
    [self initGiftButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化界面
-(void)initSwitchButton {
    self.switchButton = [LOTAnimationView animationNamed:@"SwitchControl"];
    self.switchButton.contentMode = UIViewContentModeScaleAspectFit;
    //switchButton的width和height从AE文件中获得
//    self.switchButton.frame = CGRectMake(10, 100, 216/2, 116/2);
    UITapGestureRecognizer *switchButtonTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchButtonClicked)];
    [self.switchButton addGestureRecognizer:switchButtonTapGR];
    [self.view addSubview:self.switchButton];
    @weakify(self);
    [_switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.width.equalTo(@(216/2));
        make.height.equalTo(@(116/2));
    }];
    
    [self.switchButton setValue:[UIColor orangeColor] forKeypath:@"Background 2.Shape 1.Fill 1.Color" atFrame:@(0)];
    [self.switchButton setValue:[UIColor blueColor] forKeypath:@"Background 2.Shape 1.Fill 1.Color" atFrame:@(13)];
    [self.switchButton logHierarchyKeypaths];
}

-(void)initEditButton {
    self.editButton = [LOTAnimationView animationNamed:@"Edit"];
    self.editButton.contentMode = UIViewContentModeScaleAspectFit;
    //editButton的width和height从AE文件中获得
//    self.editButton.frame = CGRectMake(150, 100, 124/2, 124/2);
    UITapGestureRecognizer *editButtonTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editButtonClicked)];
    [self.editButton addGestureRecognizer:editButtonTapGR];
    [self.view addSubview:self.editButton];
    @weakify(self);
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.switchButton.mas_bottom).offset(20);
        make.width.equalTo(@(124/2));
        make.height.equalTo(@(124/2));
    }];
    [self.editButton setProgressWithFrame:@(54)];
}

-(void)initPlayButton {
    self.playButton = [LOTAnimationView animationNamed:@"Play-Pause"];
    self.playButton.contentMode = UIViewContentModeScaleAspectFit;
    //playButton的width和height从AE文件中获得
//    self.playButton.frame = CGRectMake(230, 100, 160/2, 160/2);
    UITapGestureRecognizer *playButtonTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playButtonClicked)];
    [self.playButton addGestureRecognizer:playButtonTapGR];
    [self.view addSubview:self.playButton];
    @weakify(self);
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.editButton.mas_bottom).offset(20);
        make.width.equalTo(@(160/2));
        make.height.equalTo(@(160/2));
    }];
    [self.playButton setProgressWithFrame:@(50)];
}

-(void)initGiftButton {
    self.giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.giftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.giftButton setTitle:@"播放高级礼物动画" forState:UIControlStateNormal];
    [self.giftButton addTarget:self action:@selector(giftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.giftButton];
    @weakify(self);
    [_giftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.playButton.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15.f);
        make.right.equalTo(self.view).offset(-15.f);
        make.height.equalTo(@(30));
    }];
}

#pragma mark - Private Methods

- (void)switchButtonClicked {
    if (self.isOff) {
        [self.switchButton playFromFrame:@(13) toFrame:@(0) withCompletion:nil];
        NSLog(@"打开开关...");
    } else {
        [self.switchButton playFromFrame:@(0) toFrame:@(13) withCompletion:nil];
        NSLog(@"关闭开关...");
    }
    
    self.isOff = !self.isOff;
}

- (void)editButtonClicked {
    if (self.isEditing) {
        //Lottie总是从上一次位置开始播放动画，
        //上一次位置停留的帧可能不是startFrame，在播放前，需要设置其停留到startFrmae
        [self.editButton setProgressWithFrame:@(166)];
        [self.editButton playFromFrame:@(166) toFrame:@(218) withCompletion:nil];
        
        NSLog(@"结束编辑...");
    } else {
        [self.editButton setProgressWithFrame:@(54)];
        [self.editButton playFromFrame:@(54) toFrame:@(105) withCompletion:nil];
        
        NSLog(@"开始编辑...");
    }
    
    self.isEditing = !self.isEditing;
}

- (void)playButtonClicked {
    self.playButton.loopAnimation = NO;
    self.playButton.autoReverseAnimation = NO;
    @weakify(self);
    if (self.isPlaying) {
        [self.playButton setProgressWithFrame:@(180)];
        [self.playButton playFromFrame:@(180) toFrame:@(213) withCompletion:^(BOOL animationFinished) {
            
        }];
        
        NSLog(@"停止播放");
    } else {
        [self.playButton setProgressWithFrame:@(50)];
        [self.playButton playFromFrame:@(50) toFrame:@(90) withCompletion:^(BOOL animationFinished) {
            @strongify(self);
            self.playButton.loopAnimation = YES;
            self.playButton.autoReverseAnimation = YES;
            [self.playButton playFromFrame:@(90) toFrame:@(180) withCompletion:^(BOOL animationFinished) {
                
            }];
        }];
        
        NSLog(@"开始播放");
    }
    
    self.isPlaying = !self.isPlaying;
}

- (void)giftButtonClicked:(UIButton *)button {
    button.enabled = NO;
    
    LOTAnimationView *giftAnimationView = [LOTAnimationView animationNamed:@"HappyBirthday"];
    [self.view addSubview:giftAnimationView];
    @weakify(self);
    [giftAnimationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.giftButton.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(15.f);
        make.right.equalTo(self.view).offset(-15.f);
        make.height.equalTo(@(300));
    }];
    
    @weakify(giftAnimationView);
    [giftAnimationView playWithCompletion:^(BOOL animationFinished) {
        @strongify(giftAnimationView);
        [UIView animateWithDuration:0.5 animations:^{
            giftAnimationView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [giftAnimationView removeFromSuperview];
        }];
        
        button.enabled = YES;
    }];
}

@end
