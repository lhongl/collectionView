//
//  FDCollectionItem.m
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import "FDCollectionItem.h"
#import "FDCollectionSection.h"
#import "FDCollectionManage.h"
@interface FDCollectionItem ()
{
    id _data;
}

@property (nonatomic, copy) NSString *identifier;

@end
@implementation FDCollectionItem

- (instancetype)initWithData:(nullable id)data cellClass:(Class)cellClass{
    if (self = [super init]) {
        self.cellLayoutSize = CGSizeMake(44, 44);
        _data = data;
        NSString *cellIdent = NSStringFromClass(cellClass);
        self.identifier = cellIdent;
    }
    return self;
}

- (id)data{
    return _data;
}

- (NSString *)cellIdentifier{
    
    return self.identifier;
}

- (NSIndexPath *)indexPath{
    return [NSIndexPath indexPathForRow:[self.section.itemList indexOfObject:self] inSection:[self.section.collectionManage.sections indexOfObject:self.section]];
}

/**
 如果使用可以在子类中调用
 */
- (void)collectionManage:(FDCollectionManage *)collectionwManage cell:(__kindof UICollectionViewCell *)cell{
    
}
@end
