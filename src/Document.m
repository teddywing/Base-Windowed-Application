#import "Document.h"

@implementation Document

- (id)init
{
	self = [super init];
	if (self) {
	}
	return self;
}

// TODO: Are window controllers deallocated automatically by the parent?
// [[NSWindowController alloc] initWithWindow:]?

- (void)makeWindowControllers
{
	// DocumentWindowController *controller = [[DocumentWindowController alloc] init];

	NSWindow *window = [[NSWindow alloc]
		initWithContentRect:NSMakeRect(0, 0, 600, 500)
		styleMask:
			NSWindowStyleMaskTitled
			| NSWindowStyleMaskClosable
			| NSWindowStyleMaskMiniaturizable
			| NSWindowStyleMaskResizable
		backing:NSBackingStoreBuffered
		defer:NO];
	// [window setFrameAutosaveName:@"document"]; // document name?

	NSWindowController *window_controller = [[NSWindowController alloc]
		initWithWindow:window];
	// [window_controller setShouldCascadeWindows:YES];

	[self addWindowController:window_controller];
}

@end
