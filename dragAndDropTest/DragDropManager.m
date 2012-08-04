//
//  DragDropManager.m
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import "DragDropManager.h"
#import "DragContext.h"
#import "NSArray+Indexing.h"


@implementation DragDropManager



- (id)initWithDragSubjects:(NSArray *)dragSubjects andDropAreas:(NSArray *)dropAreas andRecogniserView:(UIView *)view {
    self = [super init];
    if (self) {
        self.dropAreas = dropAreas;
        self.dragSubjects = dragSubjects;
        self.dragContext = nil;
        
        self.uiTapGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
        [view addGestureRecognizer:self.uiTapGestureRecognizer];
    }
    
    return self;
}

- (void)beginDragObject:(UIView *)draggedView accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint pointOnView =[recognizer locationInView:recognizer.view];
    CGPoint pointOnView2 = CGPointMake(pointOnView.x - self.dragContext.startPointInSubjectsView.x, pointOnView.y - self.dragContext.startPointInSubjectsView.y);
    CGRect frame = draggedView.frame;
    frame.origin = pointOnView2;
    draggedView.frame = frame;
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        [self dragObject:draggedView accordingToGesture:recognizer];
    }];
}

/*- (void)beginDragObject:(UIView *)draggedView accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    [self dragObject:dragSubject accordingToGesture:recognizer];
}*/

- (void)dragObject:(UIView *)draggedView accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint pointOnView = [recognizer locationInView:recognizer.view];
    
    //view wird so verschoben damit er in der mitte angefasst wird
    draggedView.center = pointOnView;
}

/*- (void)dragObject:(UIView *)draggedView accordingToGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint pointOnView = [recognizer locationInView:recognizer.view];
    
    //nimm view dort wo er angefasst wurde
    CGPoint pointOnView2 = CGPointMake(pointOnView.x - self.dragContext.startPointInSubjectsView.x, pointOnView.y - self.dragContext.startPointInSubjectsView.y);
     CGRect frame = draggedView.frame;
     frame.origin = pointOnView2;
     draggedView.frame = frame;
}*/

- (BOOL)dragObject:(UIView *)viewBeingDragged startedFromView:(UIView *)originalView endedInView:(UIView *)dropArea {
    self.uiTapGestureRecognizer.enabled = NO;
    
    //wird erst mach animation gemacht
    /*[viewBeingDragged removeFromSuperview];
     [dropArea addSubview:viewBeingDragged];*/
    
    //setze viewBeingDragged an die stelle von dropArea wo los gelassen wurde
    /*CGRect frame = viewBeingDragged.frame;
     frame.origin = CGPointMake(pointInDropView.x - (viewBeingDragged.frame.size.width / 2), pointInDropView.y - (viewBeingDragged.frame.size.height / 2));
     viewBeingDragged.frame = frame;*/
    
    //setze viewBeingDragged in die mitte von dropArea
    //viewBeingDragged.center = CGPointMake((dropArea.frame.size.width / 2), (dropArea.frame.size.height / 2));
    
    int k = (dropArea.subviews.count);
    
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        //schliese mit den alten die Lücke (neu sortieren)
        for (int i=0; i<originalView.subviews.count; i++) {
            UIView *subview = originalView.subviews[i];
            subview.center = CGPointMake((subview.frame.size.width / 2) + (subview.frame.size.width * i), (originalView.frame.size.height / 2));
        }
        
        //füge in der neuen Reihe hinten an. view noch in self.view
        viewBeingDragged.center = CGPointMake((dropArea.frame.origin.x + (viewBeingDragged.frame.size.width / 2) + (viewBeingDragged.frame.size.width * k)), (dropArea.frame.origin.y + dropArea.frame.size.height / 2));
        } completion:^(BOOL finished) {
            [viewBeingDragged removeFromSuperview];
            [dropArea addSubview:viewBeingDragged];
            
            //füge in der neuen Reihe hinten an. view in dropview
            viewBeingDragged.center = CGPointMake((viewBeingDragged.frame.size.width / 2) + (viewBeingDragged.frame.size.width * k), (dropArea.frame.size.height / 2));
        
        self.uiTapGestureRecognizer.enabled = YES;
    }];

    return YES;
}

/*- (UIView *)searchSubjectHowHitsPointInRecognizer:(UIPanGestureRecognizer *)recognizer {
    for (UIView *dragSubject in self.dragSubjects) {
        CGPoint pointInSubjectsView = [recognizer locationInView:dragSubject];
        BOOL pointInSideDraggableObject = [dragSubject pointInside:pointInSubjectsView withEvent:nil];
        if (pointInSideDraggableObject) {
            return dragSubject;
        }
    }
    return nil;
}*/

- (UIView *)searchSubjectHowHitsPointInRecognizer:(UIPanGestureRecognizer *)recognizer {
    for (UIView *dropView in self.dropAreas) {
        CGPoint pointInSubjectsView = [recognizer locationInView:dropView];
        BOOL pointInSideDraggableObject = [dropView pointInside:pointInSubjectsView withEvent:nil];
        if (pointInSideDraggableObject) {
            UIView *dragSubject = nil;
            
            int index = dropView.subviews.count-1;
            if (index >= 0) {
                dragSubject = dropView.subviews[dropView.subviews.count-1];
            }
            return dragSubject;
        }
    }
    return nil;
}

- (void)dragging:(id)sender {
    UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *) sender;
    switch ((int)recognizer.state) {
        case UIGestureRecognizerStateBegan: {            
            UIView *dragSubject = [self searchSubjectHowHitsPointInRecognizer:recognizer];
            
            if (dragSubject) {                
                CGPoint pointInSubjectsView = [recognizer locationInView:dragSubject];            
#ifdef DEBUG
                NSLog(@"point%@ inside subject%@", NSStringFromCGPoint(pointInSubjectsView), NSStringFromCGRect(dragSubject.frame));
                NSLog(@"started dragging an object");
#endif
                self.dragContext = [[DragContext alloc] initWithDraggedView:dragSubject];
                self.dragContext.startPointInSubjectsView = pointInSubjectsView;
                [dragSubject removeFromSuperview];
                [recognizer.view addSubview:dragSubject];
                
                [self beginDragObject:dragSubject accordingToGesture:recognizer];

                //speichert neue Position im main view für animation
                self.dragContext.newPosition = dragSubject.frame.origin;
            } else {
#ifdef DEBUG
                NSLog(@"started drag outside drag subjects");
#endif
            }           
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if (self.dragContext) {
                [self dragObject:self.dragContext.draggedView accordingToGesture:recognizer];
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if (self.dragContext) {
                UIView *viewBeingDragged = self.dragContext.draggedView;
#ifdef DEBUG
                NSLog(@"ended drag event");
#endif
                CGPoint centerOfDraggedView = viewBeingDragged.center;
                BOOL droppedViewInKnownArea = NO;
                for (UIView *dropArea in self.dropAreas) {
                    //CGPoint pointInDropView = [recognizer locationInView:dropArea];
                    
                    //mittelpunkt von viewBeingDragged muß in dropArea sein um wechsel auszuführen
                    CGPoint pointInDropView = CGPointMake(viewBeingDragged.center.x - dropArea.frame.origin.x, viewBeingDragged.center.y - dropArea.frame.origin.y) ;
#ifdef DEBUG
                    NSLog(@"tag %i pointInDropView %@ center of dragged view %@", dropArea.tag, NSStringFromCGPoint(pointInDropView), NSStringFromCGPoint(centerOfDraggedView));
#endif
                    if ([dropArea pointInside:pointInDropView withEvent:nil]) {
                        droppedViewInKnownArea = [self dragObject:viewBeingDragged startedFromView:self.dragContext.originalView endedInView:dropArea];
#ifdef DEBUG
                        NSLog(@"dropped subject %@ on to view tag %i", NSStringFromCGRect(viewBeingDragged.frame), dropArea.tag);
#endif
                    }
                }
                
                if (!droppedViewInKnownArea) {
#ifdef DEBUG
                    NSLog(@"release draggable object outside target views - snapping back to last known location");
#endif
                    [self.dragContext snapToOriginalPosition];
                }
                
                self.dragContext = nil;
            } else {
#ifdef DEBUG
                NSLog(@"Nothing was being dragged");
#endif
            }
            break;
        }
    }
}

@end
