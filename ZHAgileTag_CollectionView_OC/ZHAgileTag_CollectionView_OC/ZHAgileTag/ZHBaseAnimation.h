//
//  ZHBaseAnimation.h
//  ZHAgileTag
//
//  Created by monkey on 2020/3/18.
//  Copyright © 2020 XunFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


typedef void(^RemoveAnimationStopBlock)(void);
typedef void(^AddAnimationStopBlock)(void);

@interface ZHBaseAnimation : CABasicAnimation

@property (nonatomic,copy)RemoveAnimationStopBlock removeAnimationStopBlock;

@property (nonatomic,copy)AddAnimationStopBlock addAnimationStopBlock;

+ (ZHBaseAnimation *)addAnimation;

+ (ZHBaseAnimation *)removeAnimation;


@end

NS_ASSUME_NONNULL_END
