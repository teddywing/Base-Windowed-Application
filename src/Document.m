#import "Document.h"

@implementation Document

- (id)init
{
	self = [super init];
	if (self) {
		_label = [[NSTextField alloc]
			initWithFrame:NSMakeRect(0, 0, 180, 20)];
		[_label setStringValue:@"Your document contents here"];
		[_label setBezeled:NO];
		[_label setDrawsBackground:NO];
		[_label setEditable:NO];
		[_label setFont:[NSFont systemFontOfSize:18]];
	}
	return self;
}

- (void)dealloc
{
	[_label release];
	[super dealloc];
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
	[[window contentView] addSubview:_label];

	// Center the label.
	NSRect content_view_frame = [[window contentView] frame];
	// NSSize window_size = [[window contentView] bounds].size;
	NSPoint content_view_center = NSMakePoint(
		NSMidX(content_view_frame),
		NSMidY(content_view_frame)
	);
	NSRect label_frame = NSMakeRect(
		content_view_center.x - 125,
		content_view_center.y,
		250,
		28
	);
	[_label setFrame:label_frame];
	[_label setAutoresizingMask:
		NSViewMinXMargin
		| NSViewMaxXMargin
		| NSViewMinYMargin
		| NSViewMaxYMargin];

	// TODO: Cascade, store previous top-left position.
	// [window cascadeTopLeftFromPoint:NSMakePoint(100, 100)];

	NSWindowController *window_controller = [[NSWindowController alloc]
		initWithWindow:window];
	// [window_controller setShouldCascadeWindows:YES];

	[self addWindowController:window_controller];
}

@end
