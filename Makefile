TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard
SYSROOT = $(THEOS)/sdks/iPhoneOS14.2.sdk
ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Rolodex

Rolodex_FILES = Tweak.xm
Rolodex_CFLAGS = -fobjc-arc -Wdeprecated-declarations -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk