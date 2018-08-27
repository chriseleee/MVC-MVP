//
//  MVCViewController.m
//  003--MVP
//
//  Created by chriseleee on 2018/8/24.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "MVCViewController.h"
#import "LMDataSource.h"
#import "MVPTableViewCell.h"
#import "Model.h"
#import <YYKit.h>


static NSString *const reuserId = @"reuserId";

@interface MVCViewController ()<UITableViewDelegate,PresentDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) LMDataSource *dataSource;


@end

@implementation MVCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    __weak __typeof(self) weakSelf = self;
    self.dataSource = [[LMDataSource alloc] initWithIdentifier:reuserId configureBlock:^(MVPTableViewCell *cell, Model *model, NSIndexPath *indexPath) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        cell.delegate = strongSelf;
        cell.indexPath = indexPath;
//        cell.model = model;
        cell.nameLabel.text = model.name;
        cell.numLabel.text  = model.num;
        
    } selectBlock:^(NSIndexPath *indexPath) {
        NSLog(@"点击了%ld行cell", (long)indexPath.row);
    }];
    [self.dataSource addDataArray:self.dataArray];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self.dataSource;
    
}
#pragma mark - lazy

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[MVPTableViewCell class] forCellReuseIdentifier:reuserId];
    }
    return _tableView;
}


#pragma mark 加载数据
- (void)loadData{

    NSArray *temArray =
    @[
      @{@"name":@"CadsC",@"imageUrl":@"http://CC",@"num":@"9"},
      @{@"name":@"Jadsfes",@"imageUrl":@"http://James",@"num":@"9"},
      @{@"name":@"Gadsfin",@"imageUrl":@"http://Gavin",@"num":@"9"},
      @{@"name":@"adci",@"imageUrl":@"http://Cooci",@"num":@"9"},
      @{@"name":@"adn",@"imageUrl":@"http://Dean ",@"num":@"9"},
      @{@"name":@"sd",@"imageUrl":@"http://CC",@"num":@"9"},
      @{@"name":@"Jadfes",@"imageUrl":@"http://James",@"num":@"9"},
      @{@"name":@"adin",@"imageUrl":@"http://Gavin",@"num":@"9"},
      @{@"name":@"adfci",@"imageUrl":@"http://Cooci",@"num":@"9"},
      @{@"name":@"CadsC",@"imageUrl":@"http://CC",@"num":@"9"},
      @{@"name":@"Jadsfes",@"imageUrl":@"http://James",@"num":@"9"},
      @{@"name":@"Gadsfin",@"imageUrl":@"http://Gavin",@"num":@"9"},
      @{@"name":@"adci",@"imageUrl":@"http://Cooci",@"num":@"9"},
      @{@"name":@"CadsC",@"imageUrl":@"http://CC",@"num":@"9"},
      @{@"name":@"Jadsfes",@"imageUrl":@"http://James",@"num":@"9"},
      @{@"name":@"Gadsfin",@"imageUrl":@"http://Gavin",@"num":@"9"},
      @{@"name":@"adci",@"imageUrl":@"http://Cooci",@"num":@"9"},
      @{@"name":@"Dsdfn",@"imageUrl":@"http://Dean ",@"num":@"9"}];
    for (int i = 0; i<temArray.count; i++) {
        Model *m = [Model modelWithDictionary:temArray[i]];
        [self.dataArray addObject:m];
    }
}



#pragma mark - PresentDelegate
- (void)didClickAddBtnWithNum:(NSString *)num indexPath:(NSIndexPath *)indexPath{
    
    
    for (int i = 0; i<self.dataArray.count; i++) {
        // 查数据 ---> 钱
        if (i == indexPath.row) {// 商品ID 容错
            Model *m = self.dataArray[indexPath.row];
            m.num    = num;
            break;
        }
    }
    
    
    if ([num intValue] > 6) {
        NSArray *temArray =
        @[
          @{@"name":@"CfC",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"sadfa",@"imageUrl":@"http://Gavin",@"num":@"9"},
          @{@"name":@"sderfx",@"imageUrl":@"http://Cooci",@"num":@"9"}];
        [self.dataArray removeAllObjects];
        for (int i = 0; i<temArray.count; i++) {
            Model *m = [Model modelWithDictionary:temArray[i]];
            [self.dataArray addObject:m];
        }
        MVPTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.delegate && [cell.delegate respondsToSelector:@selector(reloadDataForUI)]) {
            [cell.delegate reloadDataForUI];
        }
        
    }
    
}
- (void)reloadDataForUI{
    [self.dataSource addDataArray:self.dataArray];
    [self.tableView reloadData];
}

-(void)dealloc{
    NSLog(@"dealloc----%@",self);
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
