//
//  MyCollectionViewCell.h
//  ZHAgileTag_CollectionView_OC
//
//  Created by monkey on 2020/3/25.
//  Copyright © 2020 XunFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHTagModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)configCellWithModel:(ZHTagModel *)model section:(NSInteger) section;

@end

NS_ASSUME_NONNULL_END
