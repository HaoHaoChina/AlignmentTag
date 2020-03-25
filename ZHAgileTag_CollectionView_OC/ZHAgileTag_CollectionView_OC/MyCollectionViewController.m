//
//  CollectionViewController.m
//  ZHAgileTag_OC01
//
//  Created by monkey on 2020/3/24.
//  Copyright © 2020 XunFei. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "EqualSpaceFlowLayout.h"
#import "HeaderReusableView.h"
#import "ZHTagModel.h"
#import "MyCollectionViewCell.h"
#import "ZHBaseAnimation.h"

@interface MyCollectionViewController ()<EqualSpaceFlowLayoutDelegate,CAAnimationDelegate>
@property (nonatomic,strong)NSMutableArray *selectedArr;
@property (nonatomic,strong)NSArray *totalArr;
@property (nonatomic,assign)BOOL isAdding;
@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ZHAgileTag_CollectionView_OC";
    
    [self.collectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ServiceHeaderReusableView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewFooter"];

     EqualSpaceFlowLayout *flowLayout = [[EqualSpaceFlowLayout alloc] init];
     flowLayout.delegate = self;
     self.collectionView.collectionViewLayout = flowLayout;

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0)
    {
        return  self.selectedArr.count;
    }else{
        return  self.totalArr.count;

    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ZHTagModel *model = indexPath.section == 0 ? self.selectedArr[indexPath.item]:self.totalArr[indexPath.item];
    [cell configCellWithModel:model section:indexPath.section];
    
    if (indexPath.section == 0) {
        //添加时最后一个添加动画
        NSInteger count = [collectionView numberOfItemsInSection:0];
        if (self.isAdding && (indexPath.item == count - 1)) {
            ZHBaseAnimation *ani = [ZHBaseAnimation addAnimation];
            [cell.layer addAnimation:ani forKey:@"addAnimation"];
        }
    }
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader)
    {
        HeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ServiceHeaderReusableView" forIndexPath:indexPath];
        headerView.titleLabel.text = indexPath.section == 1 ?@"  全部标签":@"  已选标签";
        return headerView;
    }
    else{
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewFooter" forIndexPath:indexPath];
        return footView;
    }
}


#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld---%ld",(long)indexPath.section,(long)indexPath.item);
    
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
         self.isAdding = false;

        ZHTagModel *model = [self.selectedArr objectAtIndex:indexPath.item];
        model.isSelected = false;
        [self.selectedArr removeObjectAtIndex:indexPath.item];

         //删除时添加动画
         ZHBaseAnimation *ani = [ZHBaseAnimation removeAnimation];
         ani.delegate = self;
         [cell.layer addAnimation:ani forKey:@"removeAnimation"];
        
        
        
    }else{
       ///点击了全部标签
       ZHTagModel *model = [self.totalArr objectAtIndex:indexPath.item];
       if (![self.selectedArr containsObject:model]) {
           model.isSelected = true;
           [self.selectedArr addObject:model];
           self.isAdding = true;
           [collectionView reloadData];
       }
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIImage *img = [UIImage imageNamed:@"add"];
    CGFloat imgW = img.size.width;
    ///已选标签
    if (indexPath.section == 0) {
        ZHTagModel *model = [self.selectedArr objectAtIndex:indexPath.item];
        CGFloat titleW = [model.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width + 1;
        return CGSizeMake(titleW + imgW, 30);

    }else{
        ///全部标签
        ZHTagModel *model = [self.totalArr objectAtIndex:indexPath.item];
        CGFloat titleW = [model.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width + 1;
        return CGSizeMake(titleW + imgW, 30);
    }

        
    
}
#pragma mark - EqualSpaceFlowLayoutDelegate
-(CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath {
    return 25;
}
-(CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.selectedArr.count > 0 ? CGFLOAT_MIN:50;
    return height;
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    
    if (flag && !self.isAdding) {
         [self.collectionView reloadData];
    }
}
- (void)dealloc
{
    NSLog(@"%@--dealloc",[self class]);
}
- (NSMutableArray *)selectedArr{
    if (!_selectedArr) {
        _selectedArr = [NSMutableArray array];
    }
    return _selectedArr;
}
- (NSArray *)totalArr{
    if (!_totalArr) {
         NSArray *tempArray = @[@"文艺小青年",@"狮子座",@"90后",@"乐观",@"懵逼",@"轻度强迫症",@"密集恐惧症",@"孤僻",@"幽默",@"社交恐惧症",@"萌",@"音乐达人",@"优秀少先队员",@"2",@"不健身会死的运动达人",@"听音乐",@"民谣热",@"手机依赖症",@"成熟稳重的大叔",@"新时代愤青",@"燃",@"多重人格",@"严重人格分裂",@"抠脚大叔",@"程序员妹纸",@"加班狂魔",@"单身狗",@"电影",@"旅行的意义",@"爱幻想",@"现实主义",@"iOS开发",@"暖男"];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *str in tempArray) {
            ZHTagModel *model = [ZHTagModel new];
            model.text = str;
            model.isSelected = false;
            [arr addObject:model];
        }
        _totalArr = [NSArray arrayWithArray:arr];
    }
    return _totalArr;
}


@end
