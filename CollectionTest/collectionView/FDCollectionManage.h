//
//  FDCollectionManage.h
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDCollectionItem.h"
#import "FDCollectionSection.h"
NS_ASSUME_NONNULL_BEGIN

@interface FDCollectionManage : NSObject

@property (nonatomic, weak) UICollectionView *collectionView;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

/**
 初始化collectionView
 
 @param collectionView collectionView
 */
- (instancetype)initCollectionViewManage:(nullable UICollectionView *)collectionView;

/**
 cell注册
 
 */
- (void)registerCellWithNibName:(nonnull NSString *)nibName;

- (void)registerCellWithClass:(nullable Class)cellClass;

/**
 footer注册
 
 */
- (void)registerFooterViewWithNibName:(nonnull NSString *)nibName;

- (void)registerFooterViewWithClass:(nullable Class)aClass;

/**
 header注册
 
 */
- (void)registerHeaderViewWithNibName:(nonnull NSString *)nibName;

- (void)registerHeaderViewWithClass:(nullable Class)aClass;

/**
 添加section
 
 @param section 添加section
 */
- (void)addSection:(nullable FDCollectionSection *)section;

- (void)addSection:(nullable FDCollectionSection *)section atIndex:(NSUInteger)idx;

/**
 删除
 */
- (void)remoVeSection:(nullable FDCollectionSection *)section;

- (void)removeAllSection;

- (void)remoVeSectionatIndex:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END