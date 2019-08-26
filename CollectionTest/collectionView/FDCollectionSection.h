//
//  FDCollectionSection.h
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FDCollectionItem.h"
#import "FDCollectionSectionHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface FDCollectionSection : NSObject

@property (nonatomic, weak) FDCollectionManage *collectionManage;

/**
 下标
 */
@property (nonatomic, assign, readonly) NSInteger section;

/**
 headerIdent
 */
@property (nonatomic, copy, readonly) NSString *sectionHeaderIdent;

/**
 footerIdent
 */
@property (nonatomic, copy, readonly) NSString *sectionFooterIdent;

/**
 item数据
 */
@property (nonatomic, strong, readonly) NSArray <FDCollectionItem *> *itemList;

/**
  上下左右边距
 */
@property (nonatomic, assign) UIEdgeInsets layoutEdgeInsets;

/**
 可以根据section 设置不同section item的行间距
 */
@property (nonatomic, assign) CGFloat minimumLineSpacingForSection;

/**
 可以根据section 设置不同section item的列间距
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacingForSection;

/**
 header宽高
 */
@property (nonatomic, copy) FDCollectionSectionSizeForHeader sizeForHeader;

/**
 footer宽高
 */
@property (nonatomic, copy) FDCollectionSectionSizeForFooter sizeForFooter;

/**
 初始化
 */
+ (instancetype)section;

/**
 删除item
 */
- (void)removeAllItem;

- (void)removeItemWithIndex:(NSInteger)index;

- (void)remoVeItemWithArray:(NSArray <FDCollectionItem *>*)array;

- (void)removeItem:(FDCollectionItem *)item;


/**
 添加item
 */
- (void)addItem:(FDCollectionItem *)item;

- (void)insertItem:(FDCollectionItem *)item atIndex:(NSUInteger)idx;

- (void)addItemFromArray:(NSArray <FDCollectionItem *>*)array;


// ***************************列出。返回headerView和footerView【下方法和属性配合使用】********************
/**
 FDSectionHeaderView和FDSectionFooterView
【说明】- (void)dequeueReusableHeaderClass:(nullable Class)headerClass footerClass:(nullable Class)footerClass; 不使用则属性无效
 */

/**
 返回对应headerView 【返回可以赋值】
 */
@property (nonatomic, copy) FDCollectionSectionViewForHeader viewForHeader;
/**
 返回对应footerView 【返回可以赋值】
 */
@property (nonatomic, copy) FDCollectionSectionviewForFooter viewForFooter;

/**
 列出header和footer
 @param headerClass header类
 @param footerClass footer类
 */
- (void)dequeueReusableHeaderClass:(nullable Class)headerClass footerClass:(nullable Class)footerClass;

@end

NS_ASSUME_NONNULL_END
