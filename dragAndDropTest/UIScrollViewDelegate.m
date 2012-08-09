//
//  UIScrollViewDelegate.m
//  dragAndDropTest
//
//  Created by Mario Adrian on 06.08.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import "UIScrollViewDelegate.h"
#import "NSArray+Indexing.h"

@implementation UIScrollViewDelegate

- (id)init {
    self = [super init];
    if (self) {
        _minimumZoomScale = 1.0;
        _maximumZoomScale = 10.0;
        _zoomEnabled = YES;
        
        self.scrollView.scrollsToTop = NO;
    }
    
    return self;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    UIView *view = nil;
    
    if (_zoomEnable == YES) {
        view = self.viewForZoomingInScrollView;
    }
    
    return self.viewForZoomingInScrollView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    NSLog(@"scale %f", scale);
}

- (void)setZoomEnabled:(BOOL)zoomEnabled;
{
    _zoomEnabled = zoomEnabled;
    
    UIScrollView *scrollView = self.scrollView;
    
    if (zoomEnabled) {
        scrollView.minimumZoomScale = self.minimumZoomScale;
        scrollView.maximumZoomScale = self.maximumZoomScale;
    } else {
        scrollView.minimumZoomScale = 0.0f;
        scrollView.maximumZoomScale = 0.0f;
    }
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    self.scrollView.scrollEnabled = scrollEnabled;
}

- (BOOL)isScrollEnabled {
    return self.scrollView.isScrollEnabled;
}

@end
