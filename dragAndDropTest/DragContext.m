//
//  DragContext.m
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import "DragContext.h"

@implementation DragContext


- (id)initWithDraggedView:(UIView *)draggedView {
    self = [super init];
    if (self) {
        self.draggedView = draggedView;
        self.originalPosition = draggedView.frame.origin;
        self.originalView = draggedView.superview;
        _viewCopy = NO;
    }
    
    return self;
}

- (void)snapToOriginalPosition {
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        CGRect frame = self.draggedView.frame;
        frame.origin = self.newPosition;
        self.draggedView.frame = frame;
        
    } completion:^(BOOL finished) {
        [self.draggedView removeFromSuperview];
        
        if (_viewCopy == NO) {
            [self.originalView addSubview:self.draggedView];
            CGRect frame = self.draggedView.frame;
            frame.origin = self.originalPosition;
            self.draggedView.frame = frame;
        }
    }];
        
    //[self.draggedView removeFromSuperview];
    //[self.originalView addSubview:_draggedView];
    //self.draggedView.frame = CGRectMake(_originalPosition.x, _originalPosition.y, _draggedView.frame.size.width, _draggedView.frame.size.height);
}


@end
