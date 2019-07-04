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

@property (nonatomic, copy, readonly) NSString *sectionHeaderIdent;

@property (nonatomic, copy, readonly) NSString *sectionFooterIdent;

@property (nonatomic, strong, readonly) NSArray <FDCollectionItem *> *itemList;

@property (nonatomic, assign) UIEdgeInsets layoutEdgeInsets; //上下左右边距

@property (nonatomic, assign) CGFloat minimumLineSpacingForSection; //可以根据section 设置不同section item的行间距

@property (nonatomic, assign) CGFloat minimumInteritemSpacingForSection; // 可以根据section 设置不同section item的列间距

@property (nonatomic, assign) CGSize sizeForHeader;

@property (nonatomic, assign) CGSize sizeForFooter;

@property (nonatomic, copy) FDCollectionSectionCustomViewForHeader customViewForHeader;

@property (nonatomic, copy) FDCollectionSectionCustomViewForFooter customViewForFooter;

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

- (void)removeItem:(nullable FDCollectionItem *)item;


/**
 添加item
 */
- (void)addItem:(nullable FDCollectionItem *)item;

- (void)insertItem:(nullable FDCollectionItem *)item atIndex:(NSUInteger)idx;

- (void)addItemFromArray:(NSArray <FDCollectionItem *>*)array;


// ***************************复用 返回headerView和footerView【下方法和属性配合使用】********************
/**
 FDSectionHeaderView和FDSectionFooterView
【说明】- (void)dequeueReusableHeaderClass:(nullable Class)headerClass footerClass:(nullable Class)footerClass; 该属性无效
 */
@property (nonatomic, copy) FDCollectionSectionViewForHeader viewForHeader;//返回对应headerView

@property (nonatomic, copy) FDCollectionSectionviewForFooter viewForFooter;//返回对应footerView

/**
 复用header和footer
 @param headerClass header类
 @param footerClass footer类
 */
- (void)dequeueReusableHeaderClass:(nullable Class)headerClass footerClass:(nullable Class)footerClass;

@end

NS_ASSUME_NONNULL_END
