//
//  L_ServiceHeaderReusableView.m
//  Looktm
//
//  Created by haohao on 2017/5/12.
//  Copyright © 2017年 北京聚集科技有限公司. All rights reserved.
//

#import "HeaderReusableView.h"

@implementation HeaderReusableView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    return self;
}

@end
