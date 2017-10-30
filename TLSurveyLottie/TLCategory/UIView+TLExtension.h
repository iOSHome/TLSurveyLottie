//
//  UIView+TLExtension.h
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TLExtension)

/**
 *  重写set/get方法,快速获取/变更frame
 */
@property (nonatomic ,assign) CGFloat x;
@property (nonatomic ,assign) CGFloat y;
@property (nonatomic ,assign) CGFloat width;
@property (nonatomic ,assign) CGFloat height;
@property (nonatomic ,assign) CGFloat centerX;
@property (nonatomic ,assign) CGFloat centerY;
@property (nonatomic ,assign) CGSize size;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@end
