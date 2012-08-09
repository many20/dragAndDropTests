//
//  SecondViewController.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollViewDelegate.h"

@interface SecondViewController : UIViewController <UIGestureRecognizerDelegate> {
    
    UIView *_currentSelectView, *_destinationView;
    BOOL _objectSelected, _panGestureRecognizerEnabled;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *viewArray;
@property (nonatomic, strong) IBOutletCollection(UIGestureRecognizer) NSArray *recognizers;

@property (nonatomic, strong) IBOutlet UIScrollViewDelegate *scrollViewDelegate;


- (IBAction)tap:(UIButton *)sender;
- (IBAction)deselect:(id)sender;
- (IBAction)pan:(id)sender;

@end
