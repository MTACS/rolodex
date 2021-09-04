#import "Tweak.h"

%hook UITableViewIndex
- (NSString *)selectedSectionTitle {
	UIWindow *root = [[UIApplication sharedApplication] keyWindow];
	if (rolodexView == nil) {
		rolodexView = [[_UIBackdropView alloc] initWithFrame:CGRectMake((WIDTH / 2) - 75, (HEIGHT / 2) - 75, 150, 150) autosizesToFitSuperview:NO settings:[_UIBackdropViewSettings settingsForStyle:2]];
	} else {
		rolodexView.alpha = 1.0;
	}
	rolodexView.layer.cornerRadius = 20;
	rolodexView.layer.masksToBounds = YES;
	if (rolodexLabel == nil) {
		rolodexLabel = [[UILabel alloc] initWithFrame:rolodexView.frame];
	} else {
		rolodexLabel.alpha = 1.0;
	}
	rolodexLabel.font = [UIFont boldSystemFontOfSize:30];
	rolodexLabel.textAlignment = NSTextAlignmentCenter;
	if (%orig != NULL) {
		rolodexLabel.text = [%orig substringToIndex:1];
	}
	[rolodexView addSubview:rolodexLabel];

	[root addSubview:rolodexView];
	if (touching == NO) {
		[self performSelector:@selector(setRolodexHidden) withObject:nil afterDelay:0.5];
	}
	return %orig;
}
%new
- (void)setRolodexHidden {
	[UIView animateWithDuration:1.0 animations:^{
		rolodexLabel.alpha = 0.0;
		rolodexView.alpha = 0.0;
	}];
}
- (BOOL)beginTrackingWithTouch:(id)arg1 withEvent:(id)arg2 {
	touching = %orig;
	return %orig;
}
- (void)endTrackingWithTouch:(id)arg1 withEvent:(id)arg2 {
	%orig;
	[self setRolodexHidden];
}
- (void)dealloc {
	%orig;
	rolodexView = nil;
	rolodexLabel = nil;
}
%end