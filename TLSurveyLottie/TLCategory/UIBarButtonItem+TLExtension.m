//
//  UIBarButtonItem+TLExtension.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/30.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "UIBarButtonItem+TLExtension.h"

@implementation UIBarButtonItem (TLExtension)

+ (UIBarButtonItem *)BarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)sel{
    UIButton *textBtn = [[UIButton alloc] init];
    
    [textBtn setTitle:title forState:UIControlStateNormal];
    textBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [textBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGSize btnSize = [title sizeWithAttributes:@{NSFontAttributeName : textBtn.titleLabel.font}];
    textBtn.bounds = CGRectMake(0, 0, btnSize.width, btnSize.height);
    
    [textBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:textBtn];
    return btnItem;
}


+ (UIBarButtonItem *)BarButtonItemWithImg:(NSString *)imgName highlightedImg:(NSString *)highImgName target:(id)target action:(SEL)sel{
    UIButton *imgBtn = [[UIButton alloc] init];
    
    UIImage *img = [UIImage imageNamed:imgName];
    UIImage *selImg = highImgName.length ? [UIImage imageNamed:highImgName] : nil;
    
    imgBtn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    
    [imgBtn setImage:img forState:UIControlStateNormal];
    [imgBtn setImage:img forState:UIControlStateHighlighted];
    [imgBtn setImage:selImg forState:UIControlStateSelected];
    
    [imgBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
    return btnItem;
}

@end
