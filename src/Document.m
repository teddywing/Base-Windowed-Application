#import "Document.h"

static NSPoint *cascade_offset;

@implementation Document

- (id)init
{
	self = [super init];
	if (self) {
		NSLog(@"Checking cascade_offset");
		if (!cascade_offset) {
			NSLog(@"Setting cascade_offset");
			NSPoint p = NSMakePoint(100, 100);
			cascade_offset = &p;
			NSLog(@"Has set cascade_offset");
		}

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
		initWithContentRect:NSMakeRect(100, 50, 600, 500)
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
	if (cascade_offset) {
		// cascade_offset = NSMakePoint(100, 100);
		NSLog(@"Yes");
	}

	*cascade_offset = [window cascadeTopLeftFromPoint:*cascade_offset];

	// cascade_offset = [window frame].origin;

	NSWindowController *window_controller = [[NSWindowController alloc]
		initWithWindow:window];
	// [window_controller setShouldCascadeWindows:YES];

	[self addWindowController:window_controller];
}

@end
