//
//  FirstViewController.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragDropManager.h"

@interface FirstViewController : UIViewController

@property (nonatomic, strong) DragDropManager *dragDropManager;

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *draggableSubjects;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *droppableAreas;

@end
