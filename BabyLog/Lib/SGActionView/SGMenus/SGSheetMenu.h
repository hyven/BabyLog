//
//  SGSheetMenu.h
//  SGActionView

#import <UIKit/UIKit.h>
#import "SGBaseMenu.h"

@interface SGSheetMenu : SGBaseMenu

- (id)initWithTitle:(NSString *)title itemTitles:(NSArray *)itemTitles;

- (id)initWithTitle:(NSString *)title itemTitles:(NSArray *)itemTitles subTitles:(NSArray *)subTitles;

@property (nonatomic, assign) NSUInteger selectedItemIndex;

- (void)triggerSelectedAction:(void(^)(NSInteger))actionHandle;

@end
