//
//  SGCommonMenu.h
//  SGActionView
//  自定义 

#import <UIKit/UIKit.h>
#import "SGBaseMenu.h"

@interface SGCommonMenu : SGBaseMenu
{
    float heightForView;
}

- (id)initWithContentView:(UIView *)contentView height:(float)height;

- (void)triggerSelectedAction:(void(^)(NSInteger))actionHandle;

@end
