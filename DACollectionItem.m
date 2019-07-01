//
//  DACollectionItem.m
//  ProjectTemplate
//
//  Created by lihongliang on 2019/6/29.
//  Copyright © 2019年 李宏亮. All rights reserved.
//

#import "DACollectionItem.h"
@interface DACollectionItem ()
{
    id _data;
}
@end
@implementation DACollectionItem

- (instancetype)initWithData:(id)data cellClass:(nullable Class)cellClass{
    if (self = [super init]) {
        self.cellLayoutSize = CGSizeMake(44, 44);
        _data = data;
        NSString *cellIdent = NSStringFromClass(cellClass);
        self.cellIdentifier = cellIdent;
    }
    return self;
}

- (id)data{
    return _data;
}
@end
