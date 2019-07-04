//
//  ViewController.m
//  CollectionTest
//
//  Created by 飞渡 on 2019/7/3.
//  Copyright © 2019 freedo. All rights reserved.
//

#import "ViewController.h"
#import "FDCollectionSection.h"
#import "FDCollectionManage.h"
#import "FDCollectionItem.h"
#import "DATestCollectionViewCell.h"
@interface ViewController ()

@property (nonatomic, strong) UICollectionView *collection; //

@property (nonatomic, strong) FDCollectionManage *collectionManager; //

@property (nonatomic, strong) FDCollectionSection *section; //

@property (nonatomic, strong) FDCollectionSection *section1; //

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    self.collectionManager = [[FDCollectionManage alloc] initCollectionViewManage:collection];
    self.section = [FDCollectionSection section];
    self.section1 = [FDCollectionSection section];
    [self.collectionManager registerCellWithNibName:@"DATestCollectionViewCell"];
    [self.collectionManager addSection:self.section];
    [self.collectionManager addSection:self.section1];
    [self.view addSubview:collection];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    for (NSInteger i = 0; i < 10; i++) {
        FDCollectionItem *item = [[FDCollectionItem alloc] initWithData:nil cellClass:[DATestCollectionViewCell class]];
//        item.cellLayoutSize = CGSizeMake(100, 100);
        [self.section addItem:item];
    }
    
    for (NSInteger i = 0; i < 10; i++) {
        FDCollectionItem *item = [[FDCollectionItem alloc] initWithData:nil cellClass:[DATestCollectionViewCell class]];
        item.cellLayoutSize = CGSizeMake(100, 100);
        [self.section1 addItem:item];
    }
    [self.collection reloadData];
}


@end
