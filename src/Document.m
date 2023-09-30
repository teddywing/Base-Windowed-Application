// Copyright (c) 2023  Teddy Wing
//
// Permission to use, copy, modify, and/or distribute this software for
// any purpose with or without fee is hereby granted.
//
// THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
// WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
// AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
// DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
// PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
// TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
// PERFORMANCE OF THIS SOFTWARE.


#import "Document.h"

static NSPoint cascade_offset;

@implementation Document

- (id)init
{
	self = [super init];
	if (self) {
		_label = [[NSTextField alloc] initWithFrame:NSZeroRect];
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

- (void)makeWindowControllers
{
	NSWindow *window = [[NSWindow alloc]
		initWithContentRect:NSMakeRect(100, 50, 600, 500)
		styleMask:
			NSWindowStyleMaskTitled
			| NSWindowStyleMaskClosable
			| NSWindowStyleMaskMiniaturizable
			| NSWindowStyleMaskResizable
		backing:NSBackingStoreBuffered
		defer:NO];
	[[window contentView] addSubview:_label];

	// Center the label.
	NSRect content_view_frame = [[window contentView] frame];
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

	// Store the next window origin to shift a new document window's origin.
	cascade_offset = [window cascadeTopLeftFromPoint:cascade_offset];

	NSWindowController *window_controller = [[NSWindowController alloc]
		initWithWindow:window];

	[self addWindowController:window_controller];
}

@end
