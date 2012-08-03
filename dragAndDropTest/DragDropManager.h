//
//  DragDropManager.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DragContext.h"

@interface DragDropManager : NSObject


@property (nonatomic, weak) NSArray *dragSubjects;
@property (nonatomic, weak) NSArray *dropAreas;
@property (nonatomic, strong) DragContext *dragContext;

@property (nonatomic, strong) UIPanGestureRecognizer *uiTapGestureRecognizer;

- (id)initWithDragSubjects:(NSArray *)dragSubjects andDropAreas:(NSArray *)dropAreas andRecogniserView:(UIView *)view;


@end
