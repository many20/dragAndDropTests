//
//  FirstViewController.m
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import "FirstViewController.h"
#import "NSArray+Indexing.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dragDropManager = [[DragDropManager alloc] initWithDragSubjects:self.draggableSubjects andDropAreas:self.droppableAreas andRecogniserView:self.view];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.dragDropManager = nil;
    
    self.draggableSubjects = nil;
    self.droppableAreas = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
