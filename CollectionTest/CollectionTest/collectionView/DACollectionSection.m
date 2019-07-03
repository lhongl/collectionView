//
//  DACollectionSection.m
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import "DACollectionSection.h"
@interface DACollectionSection ()

@property (nonatomic, strong) NSMutableArray <DACollectionItem *> *dataArray;

@property (nonatomic, copy) NSString *sectionHeaderIdent;

@property (nonatomic, copy) NSString *sectionFooterIdent; //

@end

@implementation DACollectionSection

+ (instancetype)section{
    
    return [[self alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        self.sectionFooterSize = CGSizeMake(0, 0);
        self.sectionHeaderSize = CGSizeMake(0, 0);
        self.sectionLayoutEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
        self.sectionMinimumLineSpacingForSection = 0;
        self.sectionMinimumInteritemSpacingForSection = 0;
    }
    return self;
}

- (void)dequeueReusableHeaderClass:(nullable Class)headerClass footerClass:(nullable Class)footerClass{
        if (headerClass) {
            NSString *headerIdentifier = NSStringFromClass(headerClass);
            self.sectionHeaderIdent = headerIdentifier;
        }
        if (footerClass) {
            NSString *footerIdentifier = NSStringFromClass(footerClass);
            self.sectionFooterIdent = footerIdentifier;
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

- (void)remoVeItemWithArray:(NSArray <DACollectionItem *>*)array{
    if (array.count == 0) {
        return;
    }
    [self.dataArray removeObjectsInArray:array];
}

- (void)removeItem:(nullable DACollectionItem *)item{
    
    if (!item) {
#ifdef DEBUG
        NSAssert(item, @"item not Null");
#endif
        return;
    }
    [self.dataArray removeObject:item];
}

#pragma mark itemList
- (NSArray <DACollectionItem *> *)itemList{
    
    return self.dataArray;
}

#pragma mark 添加item
- (void)addItem:(nullable DACollectionItem *)item{
#ifdef DEBUG
    NSAssert(item, @"item not Null");
#endif
    if (!item) {
        return;
    }
    [self.dataArray addObject:item];
}

- (void)insertItem:(nullable DACollectionItem *)item atIndex:(NSUInteger)idx{
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

- (void)addItemFromArray:(NSArray <DACollectionItem *>*)array{
    if (array.count == 0) {
        return;
    }
    [self.dataArray addObjectsFromArray:array];
}

#pragma mark 懒加载
- (NSMutableArray <DACollectionItem *>*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSString *)sectionHeaderIdent{
    
    return self.sectionHeaderIdent;
}

- (NSString *)sectionFooterIdent{
    
    return self.sectionFooterIdent;
}

@end
