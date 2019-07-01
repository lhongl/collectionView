//
//  DACollectionManage.m
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import "DACollectionManage.h"
@interface DACollectionManage ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray <DACollectionSection *>*dataArray;

@end

@implementation DACollectionManage
#pragma  mark 初始化
- (instancetype)initTableViewManage:(UICollectionView *)collectionView {
    if (self = [super init]) {
        self.collectionView = collectionView;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
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
- (void)addSection:(DACollectionSection *)section{
    if (!section) {
#ifdef DEBUG
        NSAssert(section, @"section Not Null");
#endif
        return;
    }
    [self.dataArray addObject:section];
}

- (void)addSection:(DACollectionSection *)section atIndex:(NSUInteger)idx{
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

- (void)remoVeSection:(DACollectionSection *)section{
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
    DACollectionSection *sectionItem = self.dataArray[section];
    return sectionItem.listItem.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DACollectionSection *fdSection = self.dataArray[indexPath.section];
    DACollectionItem *item  = fdSection.listItem[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.cellIdentifier forIndexPath:indexPath];
    if (item.cellConfiguration) {
        item.cellConfiguration(self, cell, item);
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    DACollectionSection *collectionSection = self.dataArray[indexPath.row];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (collectionSection.sectionCustomHeaderView && collectionSection.sectionCustomHeaderView(indexPath.section)) {
            NSString *identifier = NSStringFromClass(collectionSection.sectionCustomHeaderView(indexPath.section));
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
            if (collectionSection.sectionCustomHeaderViewBlock) {
                collectionSection.sectionCustomHeaderViewBlock(headerView, indexPath.section);
            }
            return headerView;
        }
        if (collectionSection.sectionHeaderView) {
            return collectionSection.sectionHeaderView(indexPath.section);
        }
        return nil;
    }
     if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
         if (collectionSection.sectionCustomFooterView && collectionSection.sectionCustomFooterView(indexPath.section)) {
             NSString *identifier = NSStringFromClass(collectionSection.sectionCustomFooterView(indexPath.section));
              UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
             if (collectionSection.sectionCustomFooterViewBlock) {
                 collectionSection.sectionCustomFooterViewBlock(headerView, indexPath.section);
             }
             return headerView;
         }
         if (collectionSection.sectionFooterView) {
             return collectionSection.sectionFooterView(indexPath.section);
         }
         return nil;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DACollectionSection *fdSection = self.dataArray[indexPath.section];
    DACollectionItem *item  = fdSection.listItem[indexPath.row];
    return item.cellLayoutSize;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
     DACollectionSection *daSection = self.dataArray[section];
    return daSection.sectionLayoutEdgeInsets;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    DACollectionSection *daSection = self.dataArray[section];
    return daSection.sectionMinimumLineSpacingForSection;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    DACollectionSection *daSection = self.dataArray[section];
    return daSection.sectionMinimumInteritemSpacingForSection;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    DACollectionSection *daSection = self.dataArray[section];
    return daSection.sectionHeaderSize;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    DACollectionSection *daSection = self.dataArray[section];
    return daSection.sectionFooterSize;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DACollectionSection *fdSection = self.dataArray[indexPath.section];
    DACollectionItem *item  = fdSection.listItem[indexPath.row];
    if (item.didSelectRow) {
        item.didSelectRow(self, indexPath, item);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    DACollectionSection *fdSection = self.dataArray[indexPath.section];
    DACollectionItem *item  = fdSection.listItem[indexPath.row];
    if (item.didDeselectRow) {
        item.didDeselectRow(self, indexPath, item);
    }
}


@end
