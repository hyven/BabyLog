//
//  SGCommonMenu.m
//  SGActionView 

#import "SGCommonMenu.h"
#import <QuartzCore/QuartzCore.h>

#define kMAX_SHEET_TABLE_HEIGHT   400

@interface SGCommonMenu ()

@property (nonatomic, strong) void(^actionHandle)(NSInteger);

@end

@implementation SGCommonMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithContentView:(UIView *)contentView height:(float)height
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [self addSubview:contentView];
        heightForView=height;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, heightForView)};
}

#pragma mark - 

- (void)triggerSelectedAction:(void (^)(NSInteger))actionHandle
{
    self.actionHandle = actionHandle;
}

@end
