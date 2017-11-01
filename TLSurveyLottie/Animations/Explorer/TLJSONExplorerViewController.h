//
//  TLJSONExplorerViewController.h
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/27.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLJSONExplorerViewController : UIViewController

@property (nonatomic, copy) void (^completionBlock)(NSString *jsonURL);

@end
