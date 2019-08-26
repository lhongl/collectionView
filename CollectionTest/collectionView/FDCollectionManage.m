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
- (instancetype)initCollectionViewManage:(UICollectionView *)collectionView {
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
- (void)registerCellWithNibName:(NSString *)nibName{
    [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:nibName];
}

- (void)registerCellWithClass:(Class)cellClass{
    NSString *identifier = NSStringFromClass(cellClass);
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}


#pragma mark header和footer注册
- (void)registerHeaderViewWithNibName:(NSString *)nibName{
    [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:nibName ];
}

- (void)registerHeaderViewWithClass:(Class)aClass {
    NSString *identifier = NSStringFromClass(aClass);
    [self.collectionView registerClass:aClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)registerFooterViewWithNibName:(NSString *)nibName{
    [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:nibName ];
}

- (void)registerFooterViewWithClass:(Class)aClass {
    NSString *identifier = NSStringFromClass(aClass);
    [self.collectionView registerClass:aClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
}

#pragma mark 添加section
- (void)addSection:(FDCollectionSection *)section{
    if (!section) {
#ifdef DEBUG
        NSAssert(section, @"section Not Null");
#endif
        return;
    }
    section.collectionManage = self;
    [self.dataArray addObject:section];
}

- (void)addSection:(FDCollectionSection *)section atIndex:(NSUInteger)idx{
    if (!section) {
#ifdef DEBUG
        NSAssert(section, @"section Not Null");
#endif
        return;
    }
    
    if (self.dataArray.count < idx) {
#ifdef DEBUG
        NSString *des = [NSString stringWithFormat:@"[__NSArrayI objectAtIndex:]: index %ld beyond bounds [0 .. %ld]",idx,self.dataArray.count];
        NSAssert(NO, des);
#endif
        return;
    }
    section.collectionManage = self;
    [self.dataArray insertObject:section atIndex:idx];
}

#pragma mark 删除section
- (void)removeAllSection{
    [self.dataArray removeAllObjects];
}

- (void)remoVeSection:(FDCollectionSection *)section{
    if (!section) {
        return;
    }
    [self.dataArray removeObject:section];
}

- (void)remoVeSectionatIndex:(NSUInteger)idx{
    if (self.dataArray.count <= idx) {
#ifdef DEBUG
        NSString *des = [NSString stringWithFormat:@"[__NSArrayI objectAtIndex:]: index %ld beyond bounds [0 .. %ld]",idx,self.dataArray.count-1];
        NSAssert(NO, des);
#endif
        return;
    }
    [self.dataArray removeObjectAtIndex:idx];
}


#pragma mark 获取sections
- (NSArray <FDCollectionSection *>*)sections{
    
    return _dataArray;
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
    [item collectionManage:self cell:cell];
    if (item.cellConfiguration) {
        item.cellConfiguration(self, cell, item);
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    FDCollectionSection *collectionSection = self.dataArray[indexPath.row];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){

        if (collectionSection.sectionHeaderIdent.length == 0) {
            NSAssert(NO, @"请使用section中dequeueReusableHeaderClass列出使用对象");
            return nil;
        }
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionSection.sectionHeaderIdent forIndexPath:indexPath];
        if (collectionSection.viewForHeader) {
            collectionSection.viewForHeader(headerView, indexPath.section);
        }
        return headerView;
    }
     if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
         if (collectionSection.sectionFooterIdent.length == 0) {
             NSAssert(NO, @"请使用section中dequeueReusableHeaderClass列出使用对象");
             return nil;
         }
         UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionSection.sectionFooterIdent forIndexPath:indexPath];
         if (collectionSection.viewForFooter) {
             collectionSection.viewForFooter(footerView, indexPath.section);
         }
         return footerView;
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
    if (daSection.sizeForHeader) {
       return  daSection.sizeForHeader(section);
    }
    return CGSizeMake(0, 0);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    FDCollectionSection *daSection = self.dataArray[section];
    if (daSection.sizeForFooter) {
      return daSection.sizeForFooter(section);
    }
    return CGSizeMake(0, 0);
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count == 0) {
#ifdef DEBUG
        NSAssert(NO, @"dataArray not nil");
#endif
        return;
    }

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
