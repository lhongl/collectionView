//
//  FDCollectionSectionHeader.h
//  TestAPP
//
//  Created by 飞渡 on 2019/7/1.
//  Copyright © 2019 freedo. All rights reserved.
//

#ifndef FDCollectionSectionHeader_h
#define FDCollectionSectionHeader_h
#import <Foundation/Foundation.h>

typedef NSString * (^FDCollectionSectionHeaderTitle)(NSInteger section);

typedef NSString * (^FDCollectionSectionFooterTitle)(NSInteger section);

typedef CGSize (^FDCollectionSectionHeaderHeight)(NSInteger section);//header高

typedef CGSize (^FDCollectionSectionFooterHeight)(NSInteger section);//footer高

typedef void (^FDCollectionSectionHeaderView)(UIView *headerView ,NSInteger section);

typedef void (^FDCollectionSectionFooterView)(UIView *footerView ,NSInteger section);


#endif /* FDCollectionSectionHeader_h */
