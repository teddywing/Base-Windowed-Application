#include <stdlib.h>

#import <Cocoa/Cocoa.h>

#import "AppDelegate.h"

int main() {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSApplication *application = [NSApplication sharedApplication];
	[application setActivationPolicy:NSApplicationActivationPolicyRegular];

	NSObject<NSApplicationDelegate> *app_delegate = [[AppDelegate alloc] init];

	[application setDelegate:app_delegate];
	[application run];

	[app_delegate release];
	[pool drain];

	return EXIT_SUCCESS;
}
