//
//  NSObject+TLExtension.h
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TLExtension)

//创建UILabel
+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                      color:(UIColor *)color
                       font:(UIFont *)font
              textAlignment:(NSTextAlignment)textAlignment;

//创建UITextField
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                        placeholder:(NSString *)placeholder
                              color:(UIColor *)color
                               font:(UIFont *)font
                    secureTextEntry:(BOOL)secureTextEntry
                           delegate:(id)delegate;

//创建UITextView
+ (UITextView *)textViewWithFrame:(CGRect)frame
                             text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment;

//创建UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                        color:(UIColor *)color
                         font:(UIFont *)font
              backgroundImage:(UIImage *)backgroundImage
                       target:(id)target
                       action:(SEL)action;

//创建UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image;

+ (void)shadow:(CALayer *)layer;

@end
