//
//  TLZoomCycleImageCell.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLZoomCycleImageCell.h"

@implementation TLZoomCycleImageCell

#pragma mark ---lifeCycle---
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setupSubViews];
    }
    return self;
}


#pragma mark ---private---
- (void)setupSubViews{
    _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgView.contentMode = UIViewContentModeScaleToFill;
    _imgView.layer.shadowColor = TLHexColor(0x73e0da).CGColor;
    _imgView.layer.shadowOpacity = 0.1;
    _imgView.layer.shadowOffset = CGSizeMake(0, 3);
    
    [self.contentView addSubview:_imgView];
}

@end
