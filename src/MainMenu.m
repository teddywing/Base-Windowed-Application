#import "MainMenu.h"

NSMenuItem *MainMenuCreateApplicationMenuItem();
NSMenuItem *MainMenuCreateFileMenuItem();
NSMenu *MainMenuCreateEditMenuItem();
NSMenu *MainMenuCreateViewMenuItem();
NSMenu *MainMenuCreateWindowMenuItem();
NSMenu *MainMenuCreateHelpMenuItem();

NSMenu *MainMenuCreate()
{
	NSMenu *menubar = [[NSMenu alloc] init];

	NSMenuItem *application_menu_item = MainMenuCreateApplicationMenuItem();
	[menubar addItem:application_menu_item];

	NSMenuItem *file_menu_item = MainMenuCreateFileMenuItem();
	[menubar addItem:file_menu_item];

	[file_menu_item release];
	[application_menu_item release];

	return menubar;
}

NSMenuItem *MainMenuCreateApplicationMenuItem()
{
	NSMenuItem *application_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"Application"
		action:nil
		keyEquivalent:@""];
	NSMenu *application_menu = [[NSMenu alloc] initWithTitle:@"Application"];

	NSMenuItem *quit_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"Quit"
		action:@selector(terminate:)
		keyEquivalent:@"q"];
	[application_menu addItem:quit_menu_item];
	[application_menu_item setSubmenu:application_menu];

	[quit_menu_item release];
	[application_menu release];

	return application_menu_item;
}

NSMenuItem *MainMenuCreateFileMenuItem()
{
	NSMenuItem *file_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"File"
		action:nil
		keyEquivalent:@""];

	NSMenu *file_menu = [[NSMenu alloc] initWithTitle:@"File"];

	[file_menu_item setSubmenu:file_menu];

	[file_menu release];

	return file_menu_item;
}

NSMenu *MainMenuCreateEditMenuItem()
{
	return nil;
}

NSMenu *MainMenuCreateViewMenuItem()
{
	return nil;
}

NSMenu *MainMenuCreateWindowMenuItem()
{
	return nil;
}

NSMenu *MainMenuCreateHelpMenuItem()
{
	return nil;
}
