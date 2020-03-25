//
//  MyCollectionViewCell.m
//  ZHAgileTag_CollectionView_OC
//
//  Created by monkey on 2020/3/25.
//  Copyright © 2020 XunFei. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = true;
}

- (void)configCellWithModel:(ZHTagModel *)model section:(NSInteger) section{

    self.titleLabel.text = model.text;
    self.titleLabel.textColor = model.isSelected ? [UIColor redColor]:[UIColor blackColor];
    NSString *imgName = section == 0 ? @"delete":@"add";
    self.imageView.image = [UIImage imageNamed:imgName];

}
@end
