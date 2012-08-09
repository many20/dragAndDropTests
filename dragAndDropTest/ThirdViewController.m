//
//  SecondViewController.m
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import "ThirdViewController.h"
#import "NSArray+Indexing.h"


@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.dragDropManager = [[DragDropManager2 alloc] initWithDragSubjects:self.draggableSubjects1 andDropAreas:self.droppableAreas1 andRecogniserView:self.view];
    self.dragDropManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scrollView.contentSize = ((UIView *)self.scrollView.subviews[0]).frame.size;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.dragDropManager = nil;
    
    self.draggableSubjects1 = nil;
    self.droppableAreas1 = nil;
    self.draggableSubjects2 = nil;
    self.droppableAreas2 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)tap:(UIButton *)sender {
    NSLog(@"tap");
    
}

- (IBAction)zoomTap:(UIButton *)sender {
    NSLog(@"tap");
    
    [self.scrollView zoomToRect:sender.frame animated:YES];
}


- (void)addNewView:(UIView *)view {
    [self.generatedSubjects1 addObject:view];
}

@end
