#import "MainMenu.h"

NSMenu *MainMenuCreate()
{
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

	[quit_menu_item release];
	[application_menu release];
	[application_menu_item release];

	return menubar;
}
