//
//  DragContext.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ANIMATION_TIME 0.15f


@interface DragContext : NSObject

@property (nonatomic, strong) UIView *draggedView;
@property (nonatomic) CGPoint originalPosition;
@property (nonatomic) CGPoint newPosition;
@property (nonatomic, strong) UIView *originalView;

@property (nonatomic) CGPoint startPointInSubjectsView;
@property (nonatomic, getter = isViewCopy) BOOL viewCopy;
@property (nonatomic, getter = isDeleteViewOn) BOOL deleteViewOn;


- (id)initWithDraggedView:(UIView *)draggedView;
- (void)snapToOriginalPosition;

@end
