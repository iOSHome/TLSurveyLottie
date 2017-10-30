//
//  TLZoomCycleImageView.h
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickedCellBlock)(NSInteger index);

@interface TLZoomCycleImageView : UIView

/**
 图片广告
 */
@property (nonatomic, strong) NSArray *picArray;

/**
 回调
 */
@property (nonatomic, copy) clickedCellBlock clickedCell;

@end
