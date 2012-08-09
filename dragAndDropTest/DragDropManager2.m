//
//  DragDropManager.m
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import "DragDropManager2.h"
#import "DragContext.h"
#import "NSArray+Indexing.h"


@implementation DragDropManager2

- (UIView *)searchSubjectHowHitsPointInRecognizer:(UIPanGestureRecognizer *)recognizer {
    for (UIView *dragSubject in self.dragSubjects) {
        CGPoint pointInSubjectsView = [recognizer locationInView:dragSubject];
        BOOL pointInSideDraggableObject = [dragSubject pointInside:pointInSubjectsView withEvent:nil];
        if (pointInSideDraggableObject) {
            return dragSubject;
        }
    }
    return nil;
}

- (DragContext *)generateDragContextWithDragSubject:(UIView *)dragSubject accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    UIButton *orgButton = (UIButton *)dragSubject.subviews[0];
    
    UIView *newView = [[UIView alloc] initWithFrame:dragSubject.frame];
    newView.backgroundColor = dragSubject.backgroundColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = orgButton.frame;
    button.backgroundColor = orgButton.backgroundColor;
    
    for (id object in orgButton.allTargets) {
        NSString *action = [orgButton actionsForTarget:object forControlEvent:UIControlEventTouchUpInside][0];
        [button addTarget:object action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [newView addSubview:button];
    
    [delegate addNewView:newView];
    
    DragContext *dragContext = [[DragContext alloc] initWithDraggedView:newView];
    dragContext.viewCopy = YES;
    
    return dragContext;
}

- (void)beginDragObject:(UIView *)draggedView accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    [self dragObject:draggedView accordingToGesture:recognizer];
}

- (void)dragObject:(UIView *)draggedView accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint pointOnView = [recognizer locationInView:recognizer.view];
    
    //view wird so verschoben damit er in der mitte angefasst wird
    draggedView.center = pointOnView;
}

- (BOOL)dragObject:(UIView *)viewBeingDragged startedFromView:(UIView *)originalView endedInView:(UIView *)dropArea accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:dropArea.superview];
    if ([dropArea.superview pointInside:point withEvent:nil] == NO) {
        return NO;
    }
    
    //recognizer.enabled = NO;
    
    [viewBeingDragged removeFromSuperview];
    [dropArea addSubview:viewBeingDragged];
    [dropArea bringSubviewToFront:viewBeingDragged];
    
    //füge in dropArea an die stelle wo los gelassen wurde
    viewBeingDragged.center = [recognizer locationInView:dropArea];
    
    /*[UIView animateWithDuration:ANIMATION_TIME animations:^{
        //füge in recognizer.view an die stelle wo los gelassen wurde
        viewBeingDragged.center = [recognizer locationInView:recognizer.view];
        } completion:^(BOOL finished) {
            [viewBeingDragged removeFromSuperview];
            [dropArea addSubview:viewBeingDragged];
            [dropArea bringSubviewToFront:viewBeingDragged];
            
            //füge in dropArea an die stelle wo los gelassen wurde
            viewBeingDragged.center = [recognizer locationInView:dropArea];
            
        recognizer.enabled = YES;
    }];*/

    return YES;
}


@end
