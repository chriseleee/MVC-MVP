//
//  MVPViewController.m
//  MVPDemo
//
//  Created by Cooci on 2018/3/31.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "MVPViewController.h"
#import "LMDataSource.h"
#import "MVPTableViewCell.h"
#import "Model.h"

#import "Present.h"

static NSString *const reuserId = @"reuserId";

@interface MVPViewController ()<UITableViewDelegate,PresentDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) Present *pt;
@property (nonatomic, strong) LMDataSource *dataSource;

@end

@implementation MVPViewController

/**
 1: 解耦
 2: 解重 : nsobject
    -| 中介
    -| 封装
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pt = [[Present alloc] init];
    __weak typeof(self) weakSelf = self;
    self.dataSource = [[LMDataSource alloc] initWithIdentifier:reuserId configureBlock:^(MVPTableViewCell *cell, Model *model, NSIndexPath *indexPath) {
        // 函数式编程
        // RAC 编程思想之集大成者
        cell.nameLabel.text = model.name;
        cell.numLabel.text  = model.num;
        cell.indexPath      = indexPath;
        cell.delegate       = weakSelf.pt;
    } selectBlock:^(NSIndexPath *indexPath) {
        NSLog(@"点击了%ld行cell", (long)indexPath.row);
    }];
    [self.dataSource addDataArray:self.pt.dataArray];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.pt.delegate          = self;
}



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[MVPTableViewCell class] forCellReuseIdentifier:reuserId];
    }
    return _tableView;
}

#pragma mark - PresentDelegate
- (void)reloadDataForUI{
    [self.dataSource addDataArray:self.pt.dataArray];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
