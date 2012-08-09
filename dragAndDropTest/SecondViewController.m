//
//  SecondViewController.m
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import "SecondViewController.h"
#import "NSArray+Indexing.h"
#import "UIScrollViewDelegate.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _panGestureRecognizerEnabled = NO;
    _objectSelected = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scrollView.contentSize = ((UIView *)self.scrollView.subviews[0]).frame.size;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

//im moment nur für Pan
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"Recognizer Active %@", _panGestureRecognizerEnabled ? @"YES" : @"NO");
    return _panGestureRecognizerEnabled;
}

- (IBAction)tap:(UIButton *)sender {
    NSLog(@"tap");
    
    [_currentSelectView removeFromSuperview];
    [_destinationView removeFromSuperview];
    
    if (_currentSelectView.center.x != sender.superview.center.x && _currentSelectView.center.y != sender.superview.center.y) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        view.center = sender.superview.center;
        view.backgroundColor = [UIColor redColor];
        
        UIView *addView = _scrollView.subviews[0];
        [addView addSubview:view];
        [addView  sendSubviewToBack:view];
        _currentSelectView = view;
        _objectSelected = YES;
    } else {
        _currentSelectView = nil;
        _objectSelected = NO;
    }

    //self.scrollViewDelegate.zoomEnabled = ~_objectSelected;
    //self.scrollViewDelegate.scrollEnabled = ~_objectSelected;
    
    _panGestureRecognizerEnabled = _objectSelected;
}

- (IBAction)deselect:(id)sender {
    NSLog(@"deselect");
    
    [_currentSelectView removeFromSuperview];
    _currentSelectView = nil;
    _objectSelected = NO;
    [_destinationView removeFromSuperview];
    _destinationView = nil;
}

- (IBAction)pan:(id)sender {
    NSLog(@"pan");
}

@end
