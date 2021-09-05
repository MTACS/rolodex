TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard
SYSROOT = $(THEOS)/sdks/iPhoneOS14.2.sdk
ARCHS = arm64 arm64e
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = RLDXPrefs

RLDXPrefs_FILES = RLDXRootListController.m
RLDXPrefs_FRAMEWORKS = UIKit 
RLDXPrefs_EXTRA_FRAMEWORKS = AltList
RLDXPrefs_PRIVATE_FRAMEWORKS = Preferences 
RLDXPrefs_INSTALL_PATH = /Library/PreferenceBundles
RLDXPrefs_CFLAGS = -fobjc-arc -Wdeprecated-declarations -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/bundle.mk
