#import <AltList/ATLApplicationListControllerBase.h>
#import <AltList/ATLApplicationListMultiSelectionController.h>
#import <AltList/ATLApplicationListSelectionController.h>
#import <AltList/ATLApplicationListSubcontroller.h>
#import <AltList/ATLApplicationListSubcontrollerController.h>
#import <AltList/ATLApplicationSection.h>
#import <AltList/ATLApplicationSelectionCell.h>
#import <AltList/ATLApplicationSubtitleCell.h>
#import <AltList/ATLApplicationSubtitleSwitchCell.h>
#import <AudioToolbox/AudioServices.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>

#define TINT_COLOR [UIColor systemBlueColor]

@interface RLDXRootListController : PSListController
@property (nonatomic, retain) UIBarButtonItem *apply;
@end

@interface RLDXStyleController :PSListItemsController
@end

@interface RLDXSwitch: PSSwitchTableCell
@end

@interface RLDXTableCell : PSTableCell
@end

@interface RLDXLinkCell: PSTableCell
@end

@interface BSAction : NSObject
@end

@interface SBSRelaunchAction : BSAction
+ (id)actionWithReason:(id)arg1 options:(unsigned long long)arg2 targetURL:(id)arg3;
@end

@interface FBSSystemService : NSObject
+ (id)sharedService;
- (void)sendActions:(id)arg1 withResult:(id)arg2;
@end

