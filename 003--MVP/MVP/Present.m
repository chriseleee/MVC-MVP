//
//  Present.m
//  003--MVP
//
//  Created by Cooci on 2018/4/1.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "Present.h"

@implementation Present

- (instancetype)init{
    if (self = [super init]) {
        [self loadData];
    }
    return self;
}



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



#pragma mark - lazy

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}
#pragma mark - PresentDelegate
- (void)didClickAddBtnWithNum:(NSString *)num indexPath:(NSIndexPath *)indexPath{
    
    //    @synchronized(self){
    //
    //    }
    
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
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadDataForUI)]) {
            [self.delegate reloadDataForUI];
        }
        
    }
    
}


@end
