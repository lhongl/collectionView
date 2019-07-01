//
//  DACollectionItem.h
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DACollectionManage;
NS_ASSUME_NONNULL_BEGIN

@interface DACollectionItem : NSObject

@property (nonatomic, assign) CGSize cellLayoutSize; //item宽高

@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) void (^cellConfiguration)(__kindof DACollectionManage *tableVieManager,__kindof UICollectionViewCell *cell,__kindof DACollectionItem *item); //加载数据

@property (nonatomic, copy) void (^didSelectRow)(__kindof DACollectionManage *tableVieManager, __kindof NSIndexPath *indexPath,__kindof DACollectionItem *item); //点击

@property (nonatomic, copy) void (^didDeselectRow)(__kindof DACollectionManage *tableVieManager, __kindof NSIndexPath *indexPath,__kindof DACollectionItem *item); //点击

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithData:(id)data cellClass:(nullable Class)cellClass;

/**
 返回数据
 */
- (id)data;
@end

NS_ASSUME_NONNULL_END
