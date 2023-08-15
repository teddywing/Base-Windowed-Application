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

	NSMenuItem *about_menu_item = [application_menu
		addItemWithTitle:@"About"
		action:@selector(orderFrontStandardAboutPanel:)
		keyEquivalent:@""];
	[about_menu_item setTarget:NSApp];

	[application_menu addItem:[NSMenuItem separatorItem]];

	[application_menu
		addItemWithTitle:@"Preferences"
		action:nil
		keyEquivalent:@","];

	[application_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *services_menu_item = [application_menu
		addItemWithTitle:@"Services"
		action:nil
		keyEquivalent:@""];

	[application_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *hide_menu_item = [application_menu
		addItemWithTitle:@"Hide"
		action:nil
		keyEquivalent:@"h"];

	NSMenuItem *hide_others_menu_item = [application_menu
		addItemWithTitle:@"Hide Others"
		action:nil
		keyEquivalent:@"h"];

	NSMenuItem *show_all_menu_item = [application_menu
		addItemWithTitle:@"Show All"
		action:nil
		keyEquivalent:@""];

	[application_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *quit_menu_item = [application_menu
		addItemWithTitle:@"Quit"
		action:@selector(terminate:)
		keyEquivalent:@"q"];

	[application_menu_item setSubmenu:application_menu];

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
