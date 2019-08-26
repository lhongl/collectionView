//
//  FDCollectionSection.m
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import "FDCollectionSection.h"
#import "FDCollectionManage.h"
@interface FDCollectionSection ()

@property (nonatomic, strong) NSMutableArray <FDCollectionItem *> *dataArray;

@property (nonatomic, copy) NSString *headerIdent;

@property (nonatomic, copy) NSString *footerIdent; //

@end

@implementation FDCollectionSection

+ (instancetype)section{
    
    return [[self alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        self.layoutEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
        self.minimumLineSpacingForSection = 0;
        self.minimumInteritemSpacingForSection = 0;
    }
    return self;
}

- (void)dequeueReusableHeaderClass:(nullable Class)headerClass footerClass:(nullable Class)footerClass{
        if (headerClass) {
            NSString *headerIdentifier = NSStringFromClass(headerClass);
            self.headerIdent = headerIdentifier;
        }
        if (footerClass) {
            NSString *footerIdentifier = NSStringFromClass(footerClass);
            self.footerIdent = footerIdentifier;
        }
}

- (NSInteger)section{
    return [self.collectionManage.sections indexOfObject:self];
}

#pragma mark 删除item
- (void)removeAllItem{
    [self.dataArray removeAllObjects];
}

- (void)removeItemWithIndex:(NSInteger)index{
    if (self.dataArray.count <= index) {
#ifdef DEBUG
        NSString *des = [NSString stringWithFormat:@"[__NSArrayI objectAtIndex:]: index %ld beyond bounds [0 .. %ld]",index,self.itemList.count - 1];
        NSAssert(NO, des);
#endif
        return;
    }
    [self.dataArray removeObjectAtIndex:index];
}

- (void)remoVeItemWithArray:(NSArray <FDCollectionItem *>*)array{
    if (array.count == 0) {
        return;
    }
    [self.dataArray removeObjectsInArray:array];
}

- (void)removeItem:(FDCollectionItem *)item{
    
    if (!item) {
#ifdef DEBUG
        NSAssert(item, @"item not Null");
#endif
        return;
    }
    [self.dataArray removeObject:item];
}

#pragma mark itemList
- (NSArray <FDCollectionItem *> *)itemList{
    
    return self.dataArray;
}

#pragma mark 添加item
- (void)addItem:(FDCollectionItem *)item{
    if (!item) {
#ifdef DEBUG
        NSAssert(item, @"item not Null");
#endif
        return;
    }
    item.section = self;
    [self.dataArray addObject:item];
}

- (void)insertItem:(FDCollectionItem *)item atIndex:(NSUInteger)idx{
    if (!item) {
#ifdef DEBUG
        NSAssert(item, @"item Not Null");
#endif
        return;
    }
    
    if (self.dataArray.count < idx) {
#ifdef DEBUG
        NSString *des = [NSString stringWithFormat:@"[__NSArrayI objectAtIndex:]: index %ld beyond bounds [0 .. %ld]",idx,self.itemList.count];
        NSAssert(NO, des);
#endif
        return;
    }
    item.section = self;
    [self.dataArray insertObject:item atIndex:idx];
}

- (void)addItemFromArray:(NSArray <FDCollectionItem *>*)array{
    if (array.count == 0) {
        return;
    }
    [array enumerateObjectsUsingBlock:^(FDCollectionItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.section = self;
        [self.dataArray addObject:obj];
    }];
}

#pragma mark 懒加载
- (NSMutableArray <FDCollectionItem *>*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (NSString *)sectionHeaderIdent{
    
    return self.headerIdent;
}

- (NSString *)sectionFooterIdent{
    
    return self.footerIdent;
}

@end
