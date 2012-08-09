//
//  DragDropManager.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DragDropManager.h"
#import "DragContext.h"

@protocol DragDropManagerDelegate <NSObject>

- (void)addNewView:(UIView *)view;

@end


@interface DragDropManager2 : DragDropManager {

    
}
    
@property (nonatomic, weak) id<DragDropManagerDelegate> delegate;

@end




