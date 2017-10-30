//
//  TLNavigationController.h
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLNavigationController : UINavigationController

/**
 是否允许右滑返回
 */
@property (nonatomic, assign, getter=isBackGestureEnable) BOOL backGestureEnable;

@end
