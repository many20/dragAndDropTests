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

- (id)initWithDragSubjects:(NSArray *)dragSubjects andDropAreas:(NSArray *)dropAreas andRecogniserView:(UIView *)view {
    self = [super initWithDragSubjects:dragSubjects andDropAreas:dropAreas andRecogniserView:view];
    if (self) {
        self.viewCopy = NO;
    }
    
    return self;
}

- (UIView *)searchSubjectHowHitsPointInRecognizer:(UIPanGestureRecognizer *)recognizer {    
    for (UIView *dragSubject in self.dragSubjects) {
        CGPoint pointInSubjectsView = [recognizer locationInView:dragSubject];
        BOOL pointInSideDraggableObject = [dragSubject pointInside:pointInSubjectsView withEvent:nil];
        if (pointInSideDraggableObject) {
#ifdef DEBUG
            NSLog(@"dragSubjects found");
#endif
            
            //zu test zwecken (Normal ist NO)
            if (dragSubject.tag == 0) {
                self.viewCopy = YES;
            } else {
                self.viewCopy = NO;
            }
            
            return dragSubject;
        }
    }
    
    //suche bei den generierten Views
    for (UIView *dragSubject in self.generatedSubjects) {
        CGPoint pointInSubjectsView = [recognizer locationInView:dragSubject];
        BOOL pointInSideDraggableObject = [dragSubject pointInside:pointInSubjectsView withEvent:nil];
        if (pointInSideDraggableObject) {
#ifdef DEBUG
            NSLog(@"generatedSubjects found");
#endif
            self.viewCopy = NO;
            return dragSubject;
        }
    }
    
    return nil;
}

- (DragContext *)generateDragContextWithDragSubject:(UIView *)dragSubject accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    //wenn es keine copy ist bewege das original
    if (self.viewCopy == NO) {
        return [[DragContext alloc] initWithDraggedView:dragSubject];
    } else {
        
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
        
        [self.generatedSubjects addObject:newView];
        
        DragContext *dragContext = [[DragContext alloc] initWithDraggedView:newView];
        dragContext.viewCopy = YES;
        
        return dragContext;
    }
    
    return nil;
}

- (void)beginDragObject:(UIView *)draggedView accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    [self dragObject:draggedView accordingToGesture:recognizer];
}

- (void)dragObject:(UIView *)draggedView accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint pointOnView = [recognizer locationInView:recognizer.view];
    
    //view wird so verschoben damit er in der mitte angefasst wird
    draggedView.center = pointOnView;
    
//    if (self.dragContext.isViewCopy == NO) {
//        //auserhalb von dropAreas bewegt
//        UIView *dropArea = [self searchDropAreaHowHitsPointInRecognizer:recognizer];
//        if (dropArea == nil && self.dragContext.isDeleteViewOn == NO) {
//            self.dragContext.deleteViewOn = YES;
//            draggedView.backgroundColor = [UIColor blackColor];
//        } else if(dropArea != nil && self.dragContext.isDeleteViewOn == YES) {
//            self.dragContext.deleteViewOn = NO;
//            draggedView.backgroundColor = [UIColor whiteColor];
//        }
//    }
}

/*- (UIView *)searchDropAreaHowHitsPointInRecognizer:(UIPanGestureRecognizer *)recognizer {
    for (UIView *dropArea in self.dropAreas) {
        CGPoint pointInDropArea = [recognizer locationInView:dropArea];
        BOOL pointInSideDropArea = [dropArea pointInside:pointInDropArea withEvent:nil];
        if (pointInSideDropArea) {
#ifdef DEBUG
            //NSLog(@"dropArea found");
#endif
            return dropArea;
        }
    }
    return nil;
}*/

- (BOOL)dragObject:(UIView *)viewBeingDragged startedFromView:(UIView *)originalView endedInView:(UIView *)dropArea accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    //auserhalb des gewünschten Frames losgelassen -> abbruch
    UIScrollView *scrollView = self.delegate.scrollView;
    
    CGPoint point = [recognizer locationInView:scrollView];
    
//    CGRect visibleRect;
//    visibleRect.origin = scrollView.contentOffset;
//    visibleRect.size = scrollView.bounds.size;
//    visibleRect = CGRectApplyAffineTransform(visibleRect, CGAffineTransformMakeScale(1.0 / scrollView.zoomScale, 1.0 / scrollView.zoomScale));
    
    if ([scrollView pointInside:point withEvent:nil] == NO) {
        //lösche wenn es ein generierter view ist, sonst mache bewegung rückgängig
        if (self.dragContext.isViewCopy == NO) {
#ifdef DEBUG
            NSLog(@"viewBeingDragged delete");
#endif
            [viewBeingDragged removeFromSuperview];
            [self.generatedSubjects removeObject:viewBeingDragged];
            return YES;
        }
#ifdef DEBUG
        NSLog(@"viewBeingDragged snapToOriginalPosition");
#endif
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
