//
//  EqualSpaceFlowLayou.m
//  ZHAgileTag_OC01
//
//  Created by monkey on 2020/3/24.
//  Copyright © 2020 XunFei. All rights reserved.
//

#import "EqualSpaceFlowLayout.h"

@interface EqualSpaceFlowLayout ()
@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, strong) NSMutableArray *attrsArr;
@end


@implementation EqualSpaceFlowLayout
- (id)init
{
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 5;
        self.minimumLineSpacing = 5;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return self;
}
#pragma mark - Methods to Override
-(void)prepareLayout {
    [super prepareLayout];
    self.totalHeight = 0;
    NSMutableArray *attributesArr = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionCount; i++) {
        
        NSIndexPath *indexP = [NSIndexPath indexPathWithIndex:i];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexP];
        [attributesArr addObject:attr];
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        
        CGRect lastRect = CGRectMake(self.sectionInset.left, self.totalHeight + self.sectionInset.top, 0, 0);
        
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGSize size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            CGFloat x = 0;
            CGFloat y = 0;
            CGFloat maxX = SCREEN_WIDTH;
            CGFloat realX = CGRectGetMaxX(lastRect) + self.minimumInteritemSpacing + size.width;
            BOOL  shouldNewLine = realX > maxX;
            if (shouldNewLine) {
                x = self.sectionInset.left;
                y = CGRectGetMaxY(lastRect) + self.minimumLineSpacing;
            }else{
                x =  CGRectGetMaxX(lastRect) + (j == 0 ? 0:self.minimumInteritemSpacing);
                y = lastRect.origin.y;
            }

            attrs.frame = CGRectMake(x, y, size.width, size.height);
            [attributesArr addObject:attrs];
            lastRect = attrs.frame;
            self.totalHeight = CGRectGetMaxY(lastRect);
            if (j == itemCount - 1) {
                self.totalHeight += self.sectionInset.bottom;
            }
        }
        UICollectionViewLayoutAttributes *attr1 = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexP];
        [attributesArr addObject:attr1];
    }
    self.attrsArr = [NSMutableArray arrayWithArray:attributesArr];
}
/// contentSize
-(CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.bounds.size.width, self.totalHeight);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *layoutAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat height = 0;
    
    if (elementKind == UICollectionElementKindSectionHeader) {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfSectionHeaderForIndexPath:)]) {
            height = [_delegate heightOfSectionHeaderForIndexPath:indexPath];
        }
    } else {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfSectionFooterForIndexPath:)]) {
            height = [_delegate heightOfSectionFooterForIndexPath:indexPath];
        }
    }
    layoutAttrs.frame = CGRectMake(0, self.totalHeight, SCREEN_WIDTH, height);
    self.totalHeight += height;
    return layoutAttrs;
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}

@end
