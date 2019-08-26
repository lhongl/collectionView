//
//  FDCollectionItem.h
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FDCollectionSection,FDCollectionManage;
NS_ASSUME_NONNULL_BEGIN

@interface FDCollectionItem : NSObject


@property (nonatomic, weak) FDCollectionSection *section;

/**
 cell标识
 */
@property (nonatomic, copy, readonly) NSString *cellIdentifier;

/**
 item宽高
 */
@property (nonatomic, assign) CGSize cellLayoutSize;


/**
 加载赋值数据
 */
@property (nonatomic, copy) void (^cellConfiguration)(__kindof FDCollectionManage *tableVieManager,__kindof UICollectionViewCell *cell,__kindof FDCollectionItem *item);

/**
 点击
 */
@property (nonatomic, copy) void (^didSelectRow)(__kindof FDCollectionManage *tableVieManager, __kindof NSIndexPath *indexPath,__kindof FDCollectionItem *item);

/**
 点击
 */
@property (nonatomic, copy) void (^didDeselectRow)(__kindof FDCollectionManage *tableVieManager, __kindof NSIndexPath *indexPath,__kindof FDCollectionItem *item);

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithData:(nullable id)data cellClass:(Class)cellClass;

/**
 返回数据
 */
- (id)data;

/**
 下标
 */
- (NSIndexPath *)indexPath;


/**
 回调
 
 @param collectionwManage 管理
 @param cell cell
 */
- (void)collectionManage:(FDCollectionManage *)collectionwManage cell:(__kindof UICollectionViewCell *)cell;

@end

NS_ASSUME_NONNULL_END
