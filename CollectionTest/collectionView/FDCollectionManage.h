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
- (instancetype)initCollectionViewManage:(UICollectionView *)collectionView;

/**
 cell注册
 
 */
- (void)registerCellWithNibName:(NSString *)nibName;

- (void)registerCellWithClass:(Class)cellClass;

/**
 footer注册
 
 */
- (void)registerFooterViewWithNibName:(NSString *)nibName;

- (void)registerFooterViewWithClass:(Class)aClass;

/**
 header注册
 
 */
- (void)registerHeaderViewWithNibName:(NSString *)nibName;

- (void)registerHeaderViewWithClass:(Class)aClass;

/**
 添加section
 
 @param section 添加section
 */
- (void)addSection:(FDCollectionSection *)section;

- (void)addSection:(FDCollectionSection *)section atIndex:(NSUInteger)idx;

/**
 删除
 */
- (void)remoVeSection:(FDCollectionSection *)section;

- (void)removeAllSection;

- (void)remoVeSectionatIndex:(NSUInteger)idx;

/**
 获取sections
 */
- (NSArray <FDCollectionSection *>*)sections;

@end

NS_ASSUME_NONNULL_END
