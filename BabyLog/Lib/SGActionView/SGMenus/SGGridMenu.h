//
//  SGGridMenu.h
//  SGActionView

#import <UIKit/UIKit.h>
#import "SGBaseMenu.h"

@interface SGGridMenu : SGBaseMenu

- (id)initWithTitle:(NSString *)title itemTitles:(NSArray *)itemTitles images:(NSArray *)images;

- (void)triggerSelectedAction:(void(^)(NSInteger))actionHandle;

@end
