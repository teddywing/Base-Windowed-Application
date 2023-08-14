#import "AppDelegate.h"
#import "main_menu.h"

@implementation AppDelegate

- (void)dealloc
{
	[_window release];
	[super dealloc];
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
	NSMenu *menubar = main_menu_create();
	[NSApp setMainMenu:menubar];
	[menubar release];

	_window = [[NSWindow alloc]
		initWithContentRect:NSMakeRect(0, 0, 400, 400)
		styleMask:NSWindowStyleMaskTitled
		backing:NSBackingStoreBuffered
		defer:NO];

	[_window setTitle:@"Application"];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	[_window cascadeTopLeftFromPoint:NSMakePoint(100, 100)];
	[_window makeKeyAndOrderFront:nil];
}

@end
