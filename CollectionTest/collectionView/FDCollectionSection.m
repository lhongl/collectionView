//
//  FDCollectionSection.m
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import "FDCollectionSection.h"
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
        self.sizeForFooter = CGSizeMake(0, 0);
        self.sizeForHeader = CGSizeMake(0, 0);
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

#pragma mark 删除item
- (void)removeAllItem{
    [self.dataArray removeAllObjects];
}

- (void)removeItemWithIndex:(NSInteger)index{
    if (self.dataArray.count < index) {
        [self.dataArray removeObjectAtIndex:index];
    }
}

- (void)remoVeItemWithArray:(NSArray <FDCollectionItem *>*)array{
    if (array.count == 0) {
        return;
    }
    [self.dataArray removeObjectsInArray:array];
}

- (void)removeItem:(nullable FDCollectionItem *)item{
    
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
- (void)addItem:(nullable FDCollectionItem *)item{
#ifdef DEBUG
    NSAssert(item, @"item not Null");
#endif
    if (!item) {
        return;
    }
    [self.dataArray addObject:item];
}

- (void)insertItem:(nullable FDCollectionItem *)item atIndex:(NSUInteger)idx{
    if (!item) {
#ifdef DEBUG
        NSAssert(item, @"item Not Null");
#endif
        return;
    }
    
    if (self.dataArray.count < idx) {
#ifdef DEBUG
        NSAssert(NO, @"idx Not problem");
#endif
        return;
    }
    [self.dataArray insertObject:item atIndex:idx];
}

- (void)addItemFromArray:(NSArray <FDCollectionItem *>*)array{
    if (array.count == 0) {
        return;
    }
    [self.dataArray addObjectsFromArray:array];
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
