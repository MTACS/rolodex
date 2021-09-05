#import "Tweak.h"

static void reloadPrefs() {
  	NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCES] ?: [@{} mutableCopy];
  	enabled = [[settings objectForKey:@"enabled"] ?: @(YES) boolValue];
	style = ([settings objectForKey:@"style"] == nil ? 0 : [[settings objectForKey:@"style"] intValue]);
}

%group RLDX
%hook UITableViewIndex
- (NSString *)selectedSectionTitle {
	UIWindow *root = [[UIApplication sharedApplication] keyWindow];
	if (rolodexView == nil) {\
		int styleSetting;
		switch (style) {
			case 0:
				styleSetting = 2;
				break;
			case 1:
				styleSetting = 1001;
				break;
			case 2:
				styleSetting = 2060;
		}
		rolodexView = [[_UIBackdropView alloc] initWithFrame:CGRectMake((WIDTH / 2) - 75, (HEIGHT / 2) - 75, 150, 150) autosizesToFitSuperview:NO settings:[_UIBackdropViewSettings settingsForStyle:styleSetting]];
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
	UIColor *labelStyleSetting = nil;
	switch (style) {
		case 0:
			labelStyleSetting = [UIColor labelColor];
			break;
		case 1:
			labelStyleSetting = [UIColor whiteColor];
			break;
		case 2:
			labelStyleSetting = [UIColor blackColor];
	}
	rolodexLabel.textColor = labelStyleSetting;
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
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR(SETTINGS_NOTIF), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  	reloadPrefs();
	if (![NSProcessInfo processInfo]) return;
	NSString *processName = [NSProcessInfo processInfo].processName;
	NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
	bool shouldLoad = NO;
	NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
	NSDictionary *blacklist = [NSDictionary dictionaryWithContentsOfFile:BLACKLIST];
	NSUInteger count = args.count;
	if (count != 0) {
		NSString *executablePath = args[0];
		if (executablePath) {
			NSString *processName = [executablePath lastPathComponent];
			BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
			BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
			BOOL skip = [processName isEqualToString:@"AdSheet"]
			|| [executablePath containsString:@"Service"]
			|| [[blacklist objectForKey:@"blacklisted"] containsObject:bundleID]
			|| [executablePath rangeOfString:@".appex/"].location != NSNotFound
			|| [[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.apple.Safari.SandboxBroker"];
			if (!isFileProvider && isApplication && !skip) {
				shouldLoad = YES;
			}
		}
	}
	if (enabled && shouldLoad) {
		%init(RLDX);
		NSLog(@"[+] RLDX DEBUG: Style -> %d", style);
	}
}