//
//  UIScrollViewDelegate.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 06.08.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIScrollViewDelegate : NSObject <UIScrollViewDelegate> {
    BOOL _zoomEnable;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *viewForZoomingInScrollView;

@property(nonatomic) float minimumZoomScale;
@property(nonatomic) float maximumZoomScale;

@property (nonatomic, getter=isZoomEnabled) BOOL zoomEnabled;
@property (nonatomic, getter=isScrollEnabled) BOOL scrollEnabled;

@end
