#include <stdlib.h>

#import <Cocoa/Cocoa.h>

#import "AppDelegate.h"

int main() {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSApplication *application = [NSApplication sharedApplication];
	[application setActivationPolicy:NSApplicationActivationPolicyRegular];

	NSMenu *menubar = [[NSMenu alloc] init];
	NSMenuItem *application_menu_item = [[NSMenuItem alloc] init];
	[menubar addItem:application_menu_item];

	NSMenu *application_menu = [[NSMenu alloc] init];
	NSMenuItem *quit_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"Quit"
		action:@selector(terminate:)
		keyEquivalent:@"q"];
	[application_menu addItem:quit_menu_item];
	[application_menu_item setSubmenu:application_menu];

	[application setMainMenu:menubar];

	NSObject<NSApplicationDelegate> *app_delegate = [[AppDelegate alloc] init];

	[application setDelegate:app_delegate];
	[application run];

	[quit_menu_item release];
	[application_menu release];
	[application_menu_item release];
	[menubar release];
	[pool drain];

	return EXIT_SUCCESS;
}
