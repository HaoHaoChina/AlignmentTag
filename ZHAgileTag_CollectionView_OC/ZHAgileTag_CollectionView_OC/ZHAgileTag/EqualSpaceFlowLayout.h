//
//  EqualSpaceFlowLayou.h
//  ZHAgileTag_OC01
//
//  Created by monkey on 2020/3/24.
//  Copyright © 2020 XunFei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EqualSpaceFlowLayout;

@protocol  EqualSpaceFlowLayoutDelegate<UICollectionViewDelegate>

///每个分区Header height
-(CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;

///每个分区Footer height
-(CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;

///每个item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(EqualSpaceFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,weak) id<EqualSpaceFlowLayoutDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
