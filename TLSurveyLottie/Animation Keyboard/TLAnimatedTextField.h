//
//  TLAnimatedTextField.h
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/27.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLAnimatedTextField : UIView

@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) UIEdgeInsets scrollInsets;

- (void)changeCharactersInRange:(NSRange)range toString:(NSString *)replacementString;

@end
