//
//  DragContext.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DragContext : NSObject

@property (nonatomic, strong) UIView *draggedView;
@property (nonatomic) CGPoint originalPosition;
@property (nonatomic) CGPoint newPosition;
@property (nonatomic, strong) UIView *originalView;

@property (nonatomic) CGPoint startPointInSubjectsView;

- (id)initWithDraggedView:(UIView *)draggedView;
- (void)snapToOriginalPosition;

@end
