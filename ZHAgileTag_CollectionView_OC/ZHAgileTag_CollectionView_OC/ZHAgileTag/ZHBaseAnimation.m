//
//  ZHBaseAnimation.m
//  ZHAgileTag
//
//  Created by monkey on 2020/3/18.
//  Copyright © 2020 XunFei. All rights reserved.
//

#import "ZHBaseAnimation.h"

@implementation ZHBaseAnimation

+ (ZHBaseAnimation *)addAnimation{
    ZHBaseAnimation *animation = [ZHBaseAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @0.0;
    animation.toValue   = @1.0;
    animation.duration  = 0.2;
    animation.removedOnCompletion = NO;
    return animation;
}

+ (ZHBaseAnimation *)removeAnimation{
    ZHBaseAnimation *animation = [ZHBaseAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1.0;
    animation.toValue   = @0.0;
    animation.duration  = 0.2;
    animation.fillMode  = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

@end
