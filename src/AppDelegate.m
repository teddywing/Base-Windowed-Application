#import "AppDelegate.h"
#import "MainMenu.h"

@implementation AppDelegate

- (void)dealloc
{
	[_window release];
	[_scroll_view release];
	[_text_view release];
	// [_text_finder release];
	[super dealloc];
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
	// NSFontManager *font_manager = [NSFontManager sharedFontManager];
	// NSLog(@"FontManager: %@", [font_manager fontMenu:YES]);

	NSMenu *menubar = MainMenuCreate();
	[NSApp setMainMenu:menubar];
	[menubar release];

	_window = [[NSWindow alloc]
		initWithContentRect:NSMakeRect(0, 0, 400, 400)
		styleMask:
			NSWindowStyleMaskTitled
			| NSWindowStyleMaskClosable
			| NSWindowStyleMaskMiniaturizable
			| NSWindowStyleMaskResizable
		backing:NSBackingStoreBuffered
		defer:NO];

	[_window setTitle:@"Application"];

	_text_view = [[NSTextView alloc]
		initWithFrame:NSMakeRect(0, 0, 400, 400)];
	[_text_view setAllowsUndo:YES];
	[_text_view setUsesFindBar:YES];

	_scroll_view = [[NSScrollView alloc]
		initWithFrame:NSMakeRect(0, 0, 400, 400)];
	[_scroll_view setAutohidesScrollers:YES];
	[_scroll_view setHasVerticalScroller:YES];
	[_scroll_view setDocumentView:_text_view];

	[[_window contentView] addSubview:_scroll_view];
	// [_window setContentView:_text_view];

	// _text_finder = [[NSTextFinder alloc] init];
	// [_text_finder setClient:(id<NSTextFinderClient>)_text_view];
	// [_text_finder setFindBarContainer:_scroll_view];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	[_window cascadeTopLeftFromPoint:NSMakePoint(100, 100)];
	[_window makeKeyAndOrderFront:nil];
}

// - (IBAction)performTextFinderAction:(id)sender
// {
// 	NSLog(@"performTextFinderAction: performing %ld", [sender tag]);
// 	[_text_finder performAction:[sender tag]];
// }

@end
