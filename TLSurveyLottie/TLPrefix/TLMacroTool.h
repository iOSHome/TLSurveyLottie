//
//  TLMacroTool.h
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#ifndef TLMacroTool_h
#define TLMacroTool_h

typedef void(^returnBlock)(void);

//自定义颜色RGB
#define TLColor(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

//自定义颜色16进制
#define TLHexColor(hex) [UIColor colorWithRed:(((hex & 0xFF0000) >> 16))/255.0 green:(((hex & 0xFF00) >>8))/255.0 blue:((hex & 0xFF))/255.0 alpha:1.0]

//随机色
#define TLRandomColor JRColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

//弧度转角度
#define TLRadianToAngle(radian) ((radian) * (180.0 / M_PI))

//角度转弧度
#define TLAngleToRadian(angle) ((angle) / 180.0 * M_PI)

//判断是否为4inch
#define TLScreen40inch ([UIScreen mainScreen].bounds.size.height == 568)

//判断是否为4.7inch
#define TLScreen47inch ([UIScreen mainScreen].bounds.size.height == 667)

//判断是否为5.5inch
#define TLScreen55inch ([UIScreen mainScreen].bounds.size.height == 736)

//keyWindow
#define TLKeyWindow [UIApplication sharedApplication].keyWindow

//防止循环引用
#define WeakObj(obj) __weak typeof(obj) obj##Weak = obj

//通知中心
#define TLNotificationCenter [NSNotificationCenter defaultCenter]

//获取temp
#define TLPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define TLPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define TLPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//log
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#endif /* TLMacroTool_h */
