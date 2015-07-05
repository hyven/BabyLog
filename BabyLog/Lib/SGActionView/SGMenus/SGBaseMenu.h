//
//  SGBaseMenu.h
//  SGActionView

#import <UIKit/UIKit.h>
#import "SGActionView.h"

#define BaseMenuBackgroundColor(style)  (style == SGActionViewStyleLight ? [UIColor colorWithWhite:1.0 alpha:1.0] : [UIColor colorWithWhite:0.2 alpha:1.0])
#define BaseMenuTextColor(style)        (style == SGActionViewStyleLight ? [UIColor darkTextColor] : [UIColor lightTextColor])
#define BaseMenuActionTextColor(style)  ([UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0])

@interface SGButton : UIButton
@end

@interface SGBaseMenu : UIView{
    SGActionViewStyle _style;
}

// if rounded top left/right corner, default is YES.
@property (nonatomic, assign) BOOL roundedCorner;

@property (nonatomic, assign) SGActionViewStyle style;

@end
