//
//  DACollectionSection.h
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DACollectionItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface DACollectionSection : NSObject

@property (nonatomic, assign) UIEdgeInsets sectionLayoutEdgeInsets; //上下左右边距

@property (nonatomic, assign) CGFloat sectionMinimumLineSpacingForSection; //可以根据section 设置不同section item的行间距

@property (nonatomic, assign) CGFloat sectionMinimumInteritemSpacingForSection; // 可以根据section 设置不同section item的列间距

@property (nonatomic, assign) CGSize sectionHeaderSize;

@property (nonatomic, assign) CGSize sectionFooterSize;

@property (nonatomic, strong) NSArray <DACollectionItem *> *listItem;

@property (nonatomic, copy) UICollectionReusableView * (^sectionHeaderView)(NSInteger section);//与系统注册对应headerView

@property (nonatomic, copy) UICollectionReusableView * (^sectionFooterView)(NSInteger section);//与系统注册对应footerView

@property (nonatomic, copy) NSString * (^sectionHeaderTitle)(NSInteger section); //header

@property (nonatomic, copy) NSString * (^sectionFooterTitle)(NSInteger section); //footer

//****************自定义header和footer注册**************
@property (nonatomic, copy) Class (^sectionCustomHeaderView)(NSInteger section);

@property (nonatomic, copy) void (^sectionCustomHeaderViewBlock)(UICollectionReusableView *headerView ,NSInteger section);//返回，可以作为赋值使用

@property (nonatomic, copy) Class (^sectionCustomFooterView)(NSInteger section);

@property (nonatomic, copy) void (^sectionCustomFooterViewBlock)(UICollectionReusableView *footerView ,NSInteger section);//返回，可以作为赋值使用

/**
 删除item
 */
- (void)removeAllItem;

- (void)removeItemWithIndex:(NSInteger)index;

- (void)remoVeItemWithArray:(NSArray <DACollectionItem *>*)array;

- (void)removeItem:(DACollectionItem *)item;


/**
 添加item
 */
- (void)addItem:(DACollectionItem *)item;

- (void)insertItem:(DACollectionItem *)item atIndex:(NSUInteger)idx;

- (void)addItemFromArray:(NSArray <DACollectionItem *>*)array;

@end

NS_ASSUME_NONNULL_END
