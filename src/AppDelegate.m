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


#import "AppDelegate.h"
#import "MainMenu.h"

@implementation AppDelegate

- (void)dealloc
{
	[_window release];
	[_scroll_view release];
	[_text_view release];
	[super dealloc];
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
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

	[_window setContentView:_scroll_view];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	[_window cascadeTopLeftFromPoint:NSMakePoint(100, 100)];
	[_window makeKeyAndOrderFront:nil];
}

@end
