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

typedef void (^FDCollectionSectionViewForHeader)(UIView *headerView ,NSInteger section);

typedef void (^FDCollectionSectionviewForFooter)(UIView *footerView ,NSInteger section);

typedef CGSize (^FDCollectionSectionSizeForFooter)(NSInteger section);//footer高

typedef CGSize (^FDCollectionSectionSizeForHeader)(NSInteger section);//header高

#endif /* FDCollectionSectionHeader_h */
