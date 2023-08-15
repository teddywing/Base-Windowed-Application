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

NSString *MainMenuGetApplicationName()
{
	NSString *application_name = [[NSBundle mainBundle]
		objectForInfoDictionaryKey:@"CFBundleName"];
	if (!application_name) {
		return [[NSProcessInfo processInfo] processName];
	}

	return application_name;
}

NSMenuItem *MainMenuCreateApplicationMenuItem()
{
	NSMenuItem *application_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"Application"
		action:nil
		keyEquivalent:@""];
	NSMenu *application_menu = [[NSMenu alloc] initWithTitle:@"Application"];

	NSString *about_title = [@"About "
		stringByAppendingString:MainMenuGetApplicationName()];
	NSMenuItem *about_menu_item = [application_menu
		addItemWithTitle:about_title
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
	NSMenu *services_menu = [[NSMenu alloc] initWithTitle:@"Services"];
	[application_menu
		setSubmenu:services_menu
		forItem:services_menu_item];
	[NSApp setServicesMenu:services_menu];

	[application_menu addItem:[NSMenuItem separatorItem]];

	NSString *hide_title = [@"Hide "
		stringByAppendingString:MainMenuGetApplicationName()];
	NSMenuItem *hide_menu_item = [application_menu
		addItemWithTitle:hide_title
		action:@selector(hide:)
		keyEquivalent:@"h"];
	[hide_menu_item setTarget:NSApp];

	NSMenuItem *hide_others_menu_item = [application_menu
		addItemWithTitle:@"Hide Others"
		action:@selector(hideOtherApplications:)
		keyEquivalent:@"h"];
	[hide_others_menu_item setTarget:NSApp];
	[hide_others_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];

	NSMenuItem *show_all_menu_item = [application_menu
		addItemWithTitle:@"Show All"
		action:nil
		keyEquivalent:@""];

	[application_menu addItem:[NSMenuItem separatorItem]];

	NSString *quit_title = [@"Quit "
		stringByAppendingString:MainMenuGetApplicationName()];
	NSMenuItem *quit_menu_item = [application_menu
		addItemWithTitle:quit_title
		action:@selector(terminate:)
		keyEquivalent:@"q"];
	[quit_menu_item setTarget:NSApp];

	[application_menu_item setSubmenu:application_menu];

	[services_menu release];
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
