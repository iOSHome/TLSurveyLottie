//
//  TLJSONExplorerViewController.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/10/27.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLJSONExplorerViewController.h"

@interface TLJSONExplorerViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *jsonFiles;

@end

@implementation TLJSONExplorerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.jsonFiles = [[NSBundle mainBundle] pathsForResourcesOfType:@"json" inDirectory:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(_closePressed)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jsonFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *fileURL = self.jsonFiles[indexPath.row];
    NSArray *components = [fileURL componentsSeparatedByString:@"/"];
    cell.textLabel.text = components.lastObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fileURL = self.jsonFiles[indexPath.row];
    NSArray *components = [fileURL componentsSeparatedByString:@"/"];
    if (self.completionBlock) {
        self.completionBlock(components.lastObject);
    }
}

- (void)_closePressed {
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
}

@end
