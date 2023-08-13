#include <stdlib.h>

#import <Cocoa/Cocoa.h>

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

	NSWindow *window = [[NSWindow alloc]
		initWithContentRect:NSMakeRect(0, 0, 400, 400)
		styleMask:NSWindowStyleMaskTitled
		backing:NSBackingStoreBuffered
		defer:NO];

	[window setTitle:@"Application"];
	[window cascadeTopLeftFromPoint:NSMakePoint(100, 100)];
	[window makeKeyAndOrderFront:nil];

	[application run];

	[window release];
	[quit_menu_item release];
	[application_menu release];
	[application_menu_item release];
	[menubar release];
	[pool drain];

	return EXIT_SUCCESS;
}
