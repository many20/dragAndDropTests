//
//  SecondViewController.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragDropManager2.h"
#import "UIScrollViewDelegate.h"

#import "SVGKit.h"
#import "SVGView.h"

@interface ThirdViewController : UIViewController <UIGestureRecognizerDelegate, DragDropManagerDelegate> {
    
}

@property (nonatomic, strong) DragDropManager2 *dragDropManager;

@property (nonatomic, strong) IBOutlet UIScrollViewDelegate *scrollViewDelegate;

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *draggableSubjects1;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *droppableAreas1;

@property (nonatomic, strong) NSMutableArray *generatedSubjects1;

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *draggableSubjects2;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *droppableAreas2;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;


@property (nonatomic, retain) IBOutlet SVGView *svgView;

- (IBAction)tap:(UIButton *)sender;
- (IBAction)zoomTap:(UIButton *)sender;


@end
