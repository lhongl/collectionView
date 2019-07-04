//
//  FDCollectionItem.h
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FDCollectionManage;
NS_ASSUME_NONNULL_BEGIN

@interface FDCollectionItem : NSObject

@property (nonatomic, copy, readonly) NSString *cellIdentifier;

@property (nonatomic, assign) CGSize cellLayoutSize; //item宽高

@property (nonatomic, copy) void (^cellConfiguration)(__kindof FDCollectionManage *tableVieManager,__kindof UICollectionViewCell *cell,__kindof FDCollectionItem *item); //加载数据

@property (nonatomic, copy) void (^didSelectRow)(__kindof FDCollectionManage *tableVieManager, __kindof NSIndexPath *indexPath,__kindof FDCollectionItem *item); //点击

@property (nonatomic, copy) void (^didDeselectRow)(__kindof FDCollectionManage *tableVieManager, __kindof NSIndexPath *indexPath,__kindof FDCollectionItem *item); //点击

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithData:(nullable id)data cellClass:(nullable Class)cellClass;

/**
 返回数据
 */
- (id)data;

@end

NS_ASSUME_NONNULL_END
