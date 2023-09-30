// Copyright (c) 2023  Teddy Wing
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in
//    the documentation and/or other materials provided with the
//    distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
//    contributors may be used to endorse or promote products derived
//    from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
// OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
// AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
// WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.


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
