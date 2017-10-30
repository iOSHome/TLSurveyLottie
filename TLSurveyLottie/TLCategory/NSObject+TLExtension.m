//
//  NSObject+TLExtension.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "NSObject+TLExtension.h"

@implementation NSObject (TLExtension)

//创建UILabel
+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                      color:(UIColor *)color
                       font:(UIFont *)font
              textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}


//创建UITextField
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                        placeholder:(NSString *)placeholder
                              color:(UIColor *)color
                               font:(UIFont *)font
                    secureTextEntry:(BOOL)secureTextEntry
                           delegate:(id)delegate{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.font = font;
    textField.secureTextEntry = secureTextEntry;
    textField.delegate = delegate;
    
    return textField;
}


//创建UITextView
+ (UITextView *)textViewWithFrame:(CGRect)frame
                             text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.text = text;
    textView.textColor = color;
    textView.textAlignment = textAlignment;
    
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    
    return textView;
}


//创建UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                        color:(UIColor *)color
                         font:(UIFont *)font
              backgroundImage:(UIImage *)backgroundImage
                       target:(id)target
                       action:(SEL)action{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


//创建UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage*)image{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = image;
    
    return imgView;
}

+ (void)shadow:(CALayer *)layer{
    layer.shadowColor = TLHexColor(0x73e0da).CGColor;
    layer.shadowOpacity = 0.1;
    layer.shadowOffset = CGSizeMake(0, 3);
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
}


@end
