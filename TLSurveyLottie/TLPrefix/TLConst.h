//
//  TLConst.h
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#ifndef TLConst_h
#define TLConst_h

/**
 字符串
 */


/**
 颜色
 */
#define TLWhiteColor [UIColor whiteColor] //白色
#define TLBlackColor [UIColor blackColor] //黑色
#define TLClearColor [UIColor clearColor] //透明色
#define TLCommonTextColor TLHexColor(0x3d4c4f) //一般文字颜色
#define TLLightTextColor TLHexColor(0xa1a1a1) //浅色文字
#define TLDisabledTextColor


/**
 尺寸
 */
#define TLScreenHeight [UIScreen mainScreen].bounds.size.height //屏幕高度
#define TLScreenWidth [UIScreen mainScreen].bounds.size.width //屏幕宽度
#define TLPadding 15 //间隔
#define TLRadius 6 //圆角
#define TLHeight(height) (height * TLScreenHeight / 667) //高度缩放
#define TLWidth(width) (width * TLScreenHeight / 667) //宽度缩放


//首页
#define TLGymInfoViewHeight TLHeight(315)
#define TLZoomCycleImageViewHeight TLHeight(175)
#define TLFitnessStatusViewHeight TLHeight(225)
#define TLGymClassCellHeight TLHeight(255)
#define TLHomeTitleHeight TLHeight(50)


/**
 字体
 */
#define TLThinFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightUltraLight]
#define TLCommonFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightRegular]
#define TLBlodFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightBold]

#define TLCommonTextFontSize 15
#define TLLargeTextFontSize 20
#define TLSmallTextFontSize 11

#endif /* TLConst_h */
