#include "RLDXRootListController.h"

@import SafariServices;

@implementation RLDXRootListController
@synthesize apply;
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}
- (instancetype)init {
	self = [super init];
	if (self) {
		UIButton *applyButton = [[UIButton alloc] init];
		applyButton.frame = CGRectMake(0, 0, 30, 30);
		applyButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    	applyButton.imageEdgeInsets = UIEdgeInsetsMake(-2, -2, -2, -2);
		[applyButton setBackgroundImage:[UIImage systemImageNamed:@"checkmark.circle.fill"] forState:UIControlStateNormal];
		[applyButton addTarget:self action:@selector(applyChanges) forControlEvents:UIControlEventTouchUpInside];
		self.apply = [[UIBarButtonItem alloc] initWithCustomView:applyButton];
        self.apply.tintColor = TINT_COLOR;

        self.navigationItem.rightBarButtonItems = @[self.apply];
	}
	return self;
}
- (void)applyChanges {
	AudioServicesPlaySystemSound(1519);
	SBSRelaunchAction *respringAction = [NSClassFromString(@"SBSRelaunchAction") actionWithReason:@"RestartRenderServer" options:4 targetURL:[NSURL URLWithString:@"prefs:root=Rolodex"]];
	FBSSystemService *frontBoardService = [NSClassFromString(@"FBSSystemService") sharedService];
	NSSet *actions = [NSSet setWithObject:respringAction];

	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Rolodex" message:@"Applying changes requires a respring" preferredStyle:UIAlertControllerStyleActionSheet];
	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Respring" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
			[frontBoardService sendActions:actions withResult:nil];
        }];
    }]];
	[self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)twitter {
	[[NSBundle bundleWithPath:@"/System/Library/Frameworks/SafariServices.framework"] load];
	if ([SFSafariViewController class] != nil) {
		SFSafariViewController *safariView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://twitter.com/mtac8"]];
		if ([safariView respondsToSelector:@selector(setPreferredControlTintColor:)]) {
			safariView.preferredControlTintColor = TINT_COLOR;
		}
		[self.navigationController presentViewController:safariView animated:YES completion:nil];
	} else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/mtac8"]];
	}
}
- (void)github {
	[[NSBundle bundleWithPath:@"/System/Library/Frameworks/SafariServices.framework"] load];
	if ([SFSafariViewController class] != nil) {
		SFSafariViewController *safariView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://github.com/MTACS/Rolodex"]];
		if ([safariView respondsToSelector:@selector(setPreferredControlTintColor:)]) {
			safariView.preferredControlTintColor = TINT_COLOR;
		}
		[self.navigationController presentViewController:safariView animated:YES completion:nil];
	} else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/MTACS/Rolodex"]];
	}
}
@end

@implementation RLDXSwitch
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)identifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier specifier:specifier];
	if (self) {
		[((UISwitch *)[self control]) setOnTintColor:TINT_COLOR];
		self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
		self.detailTextLabel.textColor = TINT_COLOR;
	}
	return self;
}
- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];
	if ([self respondsToSelector:@selector(tintColor)]) {
		self.detailTextLabel.textColor = TINT_COLOR;
		self.detailTextLabel.highlightedTextColor = TINT_COLOR;
		if (([self.specifier.properties[@"key"] isEqualToString:@"enabled"])) {
			if ([(UISwitch *)self.control isOn]) {
				self.detailTextLabel.text = @"Currently: Enabled";
			} else {
				self.detailTextLabel.text = @"Currently: Disabled";
			}
		}
	}
}
- (void)controlChanged:(UISwitch *)arg1 {
	[super controlChanged:arg1];
	if (([self.specifier.properties[@"key"] isEqualToString:@"enabled"])) {
		if (arg1.isOn) {
			self.detailTextLabel.text = @"Currently: Enabled";
		} else {
			self.detailTextLabel.text = @"Currently: Disabled";
		}
	}
}
@end

@implementation RLDXTableCell
- (void)tintColorDidChange {
	[super tintColorDidChange];
	self.detailTextLabel.textColor = TINT_COLOR;
}
- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];
	if ([self respondsToSelector:@selector(tintColor)]) {
		self.detailTextLabel.textColor = TINT_COLOR;
		self.textLabel.highlightedTextColor = [UIColor labelColor];
	}
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)identifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier specifier:specifier];
	if (self) {
		self.detailTextLabel.text = specifier.properties[@"subtitle"] ?: @"";
		self.detailTextLabel.textColor = TINT_COLOR;
		self.detailTextLabel.numberOfLines = 2;
		self.textLabel.highlightedTextColor = [UIColor labelColor];
	}
	return self;
}
@end

@implementation RLDXLinkCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)identifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier specifier:specifier];
	if (self) {
		self.detailTextLabel.text = specifier.properties[@"subtitle"] ?: @"";
		self.detailTextLabel.textColor = TINT_COLOR;
		self.detailTextLabel.numberOfLines = 2;
		self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"safari.fill"]];
		self.textLabel.highlightedTextColor = [UIColor labelColor];
	}
	return self;
}
- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];
	if ([self respondsToSelector:@selector(tintColor)]) {
		self.detailTextLabel.textColor = TINT_COLOR;
		self.textLabel.textColor = [UIColor labelColor];
		self.textLabel.highlightedTextColor = [UIColor labelColor];
	}
}
@end

@implementation ATLApplicationSubtitleSwitchCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier specifier:(PSSpecifier*)specifier {
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];
	if (self) {
		[((UISwitch *)[self control]) setOnTintColor:TINT_COLOR];
		self.textLabel.textColor = TINT_COLOR;
	}
	return self;
}
- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];
	if ([self respondsToSelector:@selector(tintColor)]) {
		[((UISwitch *)[self control]) setOnTintColor:TINT_COLOR];
		self.textLabel.textColor = TINT_COLOR;
	}
}
@end

@implementation RLDXStyleController
@end