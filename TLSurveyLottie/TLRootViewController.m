//
//  TLRootViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/27.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLRootViewController.h"
#import "TLAppDelegate.h"

@interface TLRootViewController ()

@property (nonatomic, strong) NSMutableArray *tableItems;

@end

@implementation TLRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableItems = @[].mutableCopy;
    
    NSArray *item = @[
                      @{@"name" : @"Animated Explorer",
                        @"vc" : @"TLAnimationExplorerViewController"},
                      @{@"name" : @"Animated Keyboard",
                        @"vc" : @"TLAnimationKeyboardViewController"},
                      @{@"name" : @"Animated Transitions",
                        @"vc" : @"TLAnimationTransitionViewController"},
                      @{@"name" : @"Animated UIControls",
                        @"vc" : @"TLAnimationUIControlsViewController"}
                      ];
    
    [self.tableItems addObject:item];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Lottle Demo";
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableItems[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"surveyLottleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSArray *itemArray = self.tableItems[indexPath.section];
    cell.textLabel.text = itemArray[indexPath.row][@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *itemArray = self.tableItems[indexPath.section];
    
    NSString *className = itemArray[indexPath.row][@"vc"];
    Class vcClass = NSClassFromString(className);
    if (vcClass) {
        UIViewController *ctrl = [[vcClass alloc] init];
        ctrl.title = itemArray[indexPath.row][@"name"];
        
        if (indexPath.section == 0) {
            [self presentViewController:ctrl animated:YES completion:NULL];
        } else {
            TLAppDelegate *appDelegate = (TLAppDelegate *) [UIApplication sharedApplication].delegate;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                UINavigationController *navigationController = (UINavigationController *) appDelegate.viewController;
                [navigationController pushViewController:ctrl animated:YES];
            } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                UISplitViewController *splitViewController = (UISplitViewController *) appDelegate.viewController;
                UINavigationController *navigationController = [splitViewController.viewControllers objectAtIndex:1];
                [navigationController popToRootViewControllerAnimated:NO];
                [navigationController pushViewController:ctrl animated:YES];
            }
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.backgroundColor = [UIColor grayColor];
    lblTitle.textColor = [UIColor whiteColor];
    
    switch (section) {
        case 0:
        {
            lblTitle.text = @"调研清单";
            return lblTitle;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

@end
