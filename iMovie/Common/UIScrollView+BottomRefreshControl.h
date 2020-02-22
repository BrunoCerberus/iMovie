//
//  UIScrollView+BottomRefreshControl.h
//  iMovie
//
//  Created by bruno on 22/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (BottomRefreshControl)

@property (nullable, nonatomic) UIRefreshControl *bottomRefreshControl;

@end


@interface UIRefreshControl (BottomRefreshControl)

@property (nonatomic) CGFloat triggerVerticalOffset;

@end

