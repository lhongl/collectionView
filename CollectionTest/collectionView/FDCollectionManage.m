//
//  FDCollectionManage.m
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import "FDCollectionManage.h"
@interface FDCollectionManage ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray <FDCollectionSection *>*dataArray;

@end

@implementation FDCollectionManage
#pragma  mark 初始化
- (instancetype)initCollectionViewManage:(nullable UICollectionView *)collectionView {
    if (self = [super init]) {
        if (collectionView) {
            self.collectionView = collectionView;
            self.collectionView.delegate = self;
            self.collectionView.dataSource = self;
        }
    }
    return self;
}

#pragma mark cell注册
- (void)registerCellWithNibName:(nonnull NSString *)nibName{
    [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:nibName];
}

- (void)registerCellWithClass:(nullable Class)cellClass{
    NSString *identifier = NSStringFromClass(cellClass);
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}


#pragma mark header和footer注册
- (void)registerHeaderViewWithNibName:(nonnull NSString *)nibName{
    [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:nibName ];
}

- (void)registerHeaderViewWithClass:(nullable Class)aClass {
    NSString *identifier = NSStringFromClass(aClass);
    [self.collectionView registerClass:aClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)registerFooterViewWithNibName:(nonnull NSString *)nibName{
    [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:nibName ];
}

- (void)registerFooterViewWithClass:(nullable Class)aClass {
    NSString *identifier = NSStringFromClass(aClass);
    [self.collectionView registerClass:aClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
}

#pragma mark 添加section
- (void)addSection:(nullable FDCollectionSection *)section{
    if (!section) {
#ifdef DEBUG
        NSAssert(section, @"section Not Null");
#endif
        return;
    }
    [self.dataArray addObject:section];
}

- (void)addSection:(nullable FDCollectionSection *)section atIndex:(NSUInteger)idx{
    if (!section) {
#ifdef DEBUG
        NSAssert(section, @"section Not Null");
#endif
        return;
    }
    
    if (self.dataArray.count < idx) {
#ifdef DEBUG
        NSAssert(NO, @"idx problem");
#endif
        return;
    }
    [self.dataArray insertObject:section atIndex:idx];
}

#pragma mark 删除section
- (void)removeAllSection{
    [self.dataArray removeAllObjects];
}

- (void)remoVeSection:(nullable FDCollectionSection *)section{
    if (!section) {
        return;
    }
    [self.dataArray removeObject:section];
}

- (void)remoVeSectionatIndex:(NSUInteger)idx{
    if (self.dataArray.count <= idx) {
        return;
    }
    [self.dataArray removeObjectAtIndex:idx];
}

#pragma mark collection代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FDCollectionSection *sectionItem = self.dataArray[section];
    return sectionItem.itemList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FDCollectionSection *fdSection = self.dataArray[indexPath.section];
    FDCollectionItem *item  = fdSection.itemList[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.cellIdentifier forIndexPath:indexPath];
    if (item.cellConfiguration) {
        item.cellConfiguration(self, cell, item);
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    FDCollectionSection *collectionSection = self.dataArray[indexPath.row];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (collectionSection.customViewForHeader) {
            return collectionSection.customViewForHeader(indexPath.section);
        }

        if (collectionSection.sectionHeaderIdent.length == 0) {
            return nil;
        }
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionSection.sectionHeaderIdent forIndexPath:indexPath];
        if (collectionSection.viewForHeader) {
            collectionSection.viewForHeader(headerView, indexPath.section);
        }
        return headerView;
    }
     if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
         if (collectionSection.customViewForFooter) {
             return collectionSection.customViewForFooter(indexPath.section);
         }
         if (collectionSection.sectionHeaderIdent.length == 0) {
             return nil;
         }
         UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionSection.sectionHeaderIdent forIndexPath:indexPath];
         if (collectionSection.viewForFooter) {
             collectionSection.viewForFooter(headerView, indexPath.section);
         }
         return headerView;
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    FDCollectionSection *fdSection = self.dataArray[indexPath.section];
    FDCollectionItem *item  = fdSection.itemList[indexPath.row];
    return item.cellLayoutSize;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
     FDCollectionSection *daSection = self.dataArray[section];
    return daSection.layoutEdgeInsets;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    FDCollectionSection *daSection = self.dataArray[section];
    return daSection.minimumLineSpacingForSection;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    FDCollectionSection *daSection = self.dataArray[section];
    return daSection.minimumInteritemSpacingForSection;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    FDCollectionSection *daSection = self.dataArray[section];
    return daSection.sizeForHeader;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    FDCollectionSection *daSection = self.dataArray[section];
    return daSection.sizeForFooter;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FDCollectionSection *fdSection = self.dataArray[indexPath.section];
    FDCollectionItem *item  = fdSection.itemList[indexPath.row];
    if (item.didSelectRow) {
        item.didSelectRow(self, indexPath, item);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    FDCollectionSection *fdSection = self.dataArray[indexPath.section];
    FDCollectionItem *item  = fdSection.itemList[indexPath.row];
    if (item.didDeselectRow) {
        item.didDeselectRow(self, indexPath, item);
    }
}

#pragma mark 懒加载
- (NSMutableArray <FDCollectionSection *>*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
