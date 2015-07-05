//
//  SGAlertMenu.h
//  SGActionView

#import <UIKit/UIKit.h>
#import "SGBaseMenu.h"

@interface SGAlertMenu : SGBaseMenu

- (id)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSString *)buttonTitles,...;

- (void)triggerSelectedAction:(void(^)(NSInteger))actionHandle;

@end
