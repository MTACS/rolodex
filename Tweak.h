#import <UIKit/UIKit.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *domain = @"com.mtac.rldxprefs";
static NSString *PostNotificationString = @"com.mtac.rldxprefs/preferences.changed";
static BOOL enabled;
BOOL touching = NO;

@interface NSUserDefaults (RLDX)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

@interface _UIBackdropViewSettings: NSObject
+ (id)settingsForStyle:(long long)arg1;
@end

@interface _UIBackdropView: UIView
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
@end

@interface UIView (RDLX)
- (id)_viewControllerForAncestor;
@end

@interface UIWindow (RLDX)
@property (strong, nonatomic) UIView *rolodexView;
@end

@interface UITableViewIndex: UIView
- (void)setRolodexHidden;
@end

_UIBackdropView *rolodexView = nil;
UILabel *rolodexLabel = nil;