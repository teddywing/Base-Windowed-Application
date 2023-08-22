#import "MainMenu.h"

NSMenuItem *MainMenuCreateApplicationMenuItem();
NSMenuItem *MainMenuCreateFileMenuItem();
NSMenuItem *MainMenuCreateEditMenuItem();
NSMenuItem *MainMenuCreateFormatMenuItem();
NSMenuItem *MainMenuCreateViewMenuItem();
NSMenuItem *MainMenuCreateWindowMenuItem();
NSMenuItem *MainMenuCreateHelpMenuItem();

NSMenu *MainMenuCreate()
{
	NSMenu *menubar = [[NSMenu alloc] init];

	NSMenuItem *application_menu_item = MainMenuCreateApplicationMenuItem();
	[menubar addItem:application_menu_item];

	NSMenuItem *file_menu_item = MainMenuCreateFileMenuItem();
	[menubar addItem:file_menu_item];

	NSMenuItem *edit_menu_item = MainMenuCreateEditMenuItem();
	[menubar addItem:edit_menu_item];

	NSMenuItem *format_menu_item = MainMenuCreateFormatMenuItem();
	[menubar addItem:format_menu_item];

	NSMenuItem *view_menu_item = MainMenuCreateViewMenuItem();
	[menubar addItem:view_menu_item];

	NSMenuItem *window_menu_item = MainMenuCreateWindowMenuItem();
	[menubar addItem:window_menu_item];

	NSMenuItem *help_menu_item = MainMenuCreateHelpMenuItem();
	[menubar addItem:help_menu_item];

	[help_menu_item release];
	[window_menu_item release];
	[view_menu_item release];
	[format_menu_item release];
	[edit_menu_item release];
	[file_menu_item release];
	[application_menu_item release];

	return menubar;
}

NSString *MainMenuGetApplicationName()
{
	// TODO: #define this from the Makefile
	NSString *application_name = [[NSBundle mainBundle]
		objectForInfoDictionaryKey:@"CFBundleName"];
	if (!application_name) {
		return [[NSProcessInfo processInfo] processName];
	}

	return application_name;
}

NSMenuItem *MainMenuCreateApplicationMenuItem()
{
	// TODO: Localize
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

	[file_menu
		addItemWithTitle:@"New"
		action:@selector(newDocument:)
		keyEquivalent:@"n"];

	[file_menu
		addItemWithTitle:@"Open…"
		action:@selector(openDocument:)
		keyEquivalent:@"o"];

	// TODO Add a real "Open Recent" menu.
	[file_menu
		addItemWithTitle:@"Open Recent"
		action:nil
		keyEquivalent:@""];

	[file_menu addItem:[NSMenuItem separatorItem]];

	[file_menu
		addItemWithTitle:@"Close"
		action:@selector(performClose:)
		keyEquivalent:@"w"];

	[file_menu
		addItemWithTitle:@"Save…"
		action:@selector(saveDocument:)
		keyEquivalent:@"s"];

	NSMenuItem *save_as_menu_item = [file_menu
		addItemWithTitle:@"Save As…"
		action:@selector(saveDocumentAs:)
		keyEquivalent:@"s"];
	[save_as_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagShift];

	[file_menu
		addItemWithTitle:@"Revert to Saved"
		action:@selector(revertDocumentToSaved:)
		keyEquivalent:@"r"];

	[file_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *page_setup_menu_item = [file_menu
		addItemWithTitle:@"Page Setup…"
		action:@selector(runPageLayout:)
		keyEquivalent:@"p"];
	[page_setup_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagShift];

	[file_menu
		addItemWithTitle:@"Print…"
		action:@selector(print:)
		keyEquivalent:@"p"];

	[file_menu_item setSubmenu:file_menu];

	[file_menu release];

	return file_menu_item;
}

NSMenuItem *MainMenuCreateEditMenuItem()
{
	NSMenuItem *edit_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"Edit"
		action:nil
		keyEquivalent:@""];
	NSMenu *edit_menu = [[NSMenu alloc] initWithTitle:@"Edit"];

	[edit_menu
		addItemWithTitle:@"Undo"
		action:@selector(undo:)
		keyEquivalent:@"z"];

	[edit_menu
		addItemWithTitle:@"Redo"
		action:@selector(redo:)
		keyEquivalent:@"Z"];

	[edit_menu addItem:[NSMenuItem separatorItem]];

	[edit_menu
		addItemWithTitle:@"Cut"
		action:@selector(cut:)
		keyEquivalent:@"x"];

	[edit_menu
		addItemWithTitle:@"Copy"
		action:@selector(copy:)
		keyEquivalent:@"c"];

	[edit_menu
		addItemWithTitle:@"Paste"
		action:@selector(paste:)
		keyEquivalent:@"v"];

	NSMenuItem *paste_and_match_style_menu_item = [edit_menu
		addItemWithTitle:@"Paste and Match Style"
		action:@selector(pasteAsPlainText:)
		keyEquivalent:@"V"];
	[paste_and_match_style_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];

	[edit_menu
		addItemWithTitle:@"Delete"
		action:@selector(delete:)
		keyEquivalent:@""];

	[edit_menu
		addItemWithTitle:@"Select All"
		action:@selector(selectAll:)
		keyEquivalent:@"a"];

	[edit_menu addItem:[NSMenuItem separatorItem]];

	// Find menu.
	// TODO: Find items don't appear to work except for D-j
	NSMenuItem *find_menu_item = [edit_menu
		addItemWithTitle:@"Find"
		action:nil
		keyEquivalent:@""];
	NSMenu *find_menu = [[NSMenu alloc] initWithTitle:@"Find"];
	[edit_menu
		setSubmenu:find_menu
		forItem:find_menu_item];

	NSMenuItem *find_ellipsis_menu_item = [find_menu
		addItemWithTitle:@"Find…"
		action:@selector(performFindPanelAction:)
		// action:@selector(performTextFinderAction:)
		keyEquivalent:@"f"];
	[find_ellipsis_menu_item setTag:NSTextFinderActionShowFindInterface];
	// [find_ellipsis_menu_item setTag:1];
	// NSFindPanelActionShowFindPanel ?

	NSMenuItem *find_and_replace_menu_item = [find_menu
		addItemWithTitle:@"Find and Replace…"
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"f"];
	[find_and_replace_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];
	[find_and_replace_menu_item setTag:NSTextFinderActionShowReplaceInterface];

	NSMenuItem *find_next_menu_item = [find_menu
		addItemWithTitle:@"Find Next"
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"g"];
	[find_next_menu_item setTag:NSTextFinderActionNextMatch];

	NSMenuItem *find_previous_menu_item = [find_menu
		addItemWithTitle:@"Find Previous"
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"G"];
	[find_previous_menu_item setTag:NSTextFinderActionPreviousMatch];

	NSMenuItem *use_selection_for_find_menu_item = [find_menu
		addItemWithTitle:@"Use Selection for Find"
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"e"];
	[use_selection_for_find_menu_item setTag:NSTextFinderActionSetSearchString];

	[find_menu
		addItemWithTitle:@"Jump to Selection"
		action:@selector(centerSelectionInVisibleArea:)
		keyEquivalent:@"j"];

	// Spelling and Grammar menu.
	NSMenuItem *spelling_and_grammar_menu_item = [edit_menu
		addItemWithTitle:@"Spelling and Grammar"
		action:nil
		keyEquivalent:@""];
	NSMenu *spelling_and_grammar_menu = [[NSMenu alloc] initWithTitle:@"Spelling and Grammar"];
	[edit_menu
		setSubmenu:spelling_and_grammar_menu
		forItem:spelling_and_grammar_menu_item];

	[spelling_and_grammar_menu
		addItemWithTitle:@"Show Spelling and Grammar"
		action:@selector(showGuessPanel:)
		keyEquivalent:@":"];
	// NSLog(@"modifierMask: %lu", [x keyEquivalentModifierMask]);

	[spelling_and_grammar_menu
		addItemWithTitle:@"Check Document Now"
		action:@selector(checkSpelling:)
		keyEquivalent:@";"];

	[spelling_and_grammar_menu addItem:[NSMenuItem separatorItem]];

	[spelling_and_grammar_menu
		addItemWithTitle:@"Check Spelling While Typing"
		action:@selector(toggleContinuousSpellChecking:)
		keyEquivalent:@""];

	[spelling_and_grammar_menu
		addItemWithTitle:@"Check Grammar With Spelling"
		action:@selector(toggleGrammarChecking:)
		keyEquivalent:@""];

	[spelling_and_grammar_menu
		addItemWithTitle:@"Correct Spelling Automatically"
		action:@selector(toggleAutomaticSpellingCorrection:)
		keyEquivalent:@""];

	// Substitutions menu.
	NSMenuItem *substitutions_menu_item = [edit_menu
		addItemWithTitle:@"Substitutions"
		action:nil
		keyEquivalent:@""];
	NSMenu *substitutions_menu = [[NSMenu alloc] initWithTitle:@"Substitutions"];
	[edit_menu
		setSubmenu:substitutions_menu
		forItem:substitutions_menu_item];

	[substitutions_menu
		addItemWithTitle:@"Show Substitutions"
		action:@selector(orderFrontSubstitutionsPanel:)
		keyEquivalent:@""];

	[substitutions_menu addItem:[NSMenuItem separatorItem]];

	[substitutions_menu
		addItemWithTitle:@"Smart Copy/Paste"
		action:@selector(toggleSmartInsertDelete:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:@"Smart Quotes"
		action:@selector(toggleAutomaticQuoteSubstitution:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:@"Smart Dashes"
		action:@selector(toggleAutomaticDashSubstitution:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:@"Smart Links"
		action:@selector(toggleAutomaticLinkDetection:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:@"Date Detectors"
		action:@selector(toggleAutomaticDataDetection:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:@"Text Replacement"
		action:@selector(toggleAutomaticTextReplacement:)
		keyEquivalent:@""];

	NSMenuItem *transformations_menu_item = [edit_menu
		addItemWithTitle:@"Transformations"
		action:nil
		keyEquivalent:@""];
	NSMenu *transformations_menu = [[NSMenu alloc] initWithTitle:@"Transformations"];
	[edit_menu
		setSubmenu:transformations_menu
		forItem:transformations_menu_item];

	[transformations_menu
		addItemWithTitle:@"Make Upper Case"
		action:@selector(uppercaseWord:)
		keyEquivalent:@""];

	[transformations_menu
		addItemWithTitle:@"Make Lower Case"
		action:@selector(lowercaseWord:)
		keyEquivalent:@""];

	[transformations_menu
		addItemWithTitle:@"Capitalize"
		action:@selector(capitalizeWord:)
		keyEquivalent:@""];

	NSMenuItem *speech_menu_item = [edit_menu
		addItemWithTitle:@"Speech"
		action:nil
		keyEquivalent:@""];
	NSMenu *speech_menu = [[NSMenu alloc] initWithTitle:@"Speech"];
	[edit_menu
		setSubmenu:speech_menu
		forItem:speech_menu_item];

	[speech_menu
		addItemWithTitle:@"Start Speaking"
		action:@selector(startSpeaking:)
		keyEquivalent:@""];

	[speech_menu
		addItemWithTitle:@"Stop Speaking"
		action:@selector(stopSpeaking:)
		keyEquivalent:@""];

	[edit_menu_item setSubmenu:edit_menu];

	[find_menu release];
	[spelling_and_grammar_menu release];
	[substitutions_menu release];
	[transformations_menu release];
	[speech_menu release];
	[edit_menu release];

	return edit_menu_item;
}

BOOL MainMenuNSMenuItemHasKeyEquivalentModifierMaskCommand(NSMenuItem *menu_item)
{
	if (!menu_item) {
		return NO;
	}

	if (
		[menu_item keyEquivalentModifierMask]
		& NSEventModifierFlagCommand
	) {
		return YES;
	}

	return NO;
}

void MainMenuAddMissingCommandModifier(NSMenuItem *menu_item)
{
	if (MainMenuNSMenuItemHasKeyEquivalentModifierMaskCommand(menu_item)) {
		return;
	}

	[menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | [menu_item keyEquivalentModifierMask]];
}

// On Mac OS X 10.15, some menu items did not include the Apple key in the
// Font menu item's modifier mask.
//
// Fix this by adding the modifier if necessary.
void MainMenuFixFontMenuKeyEquivalentModifierMask(NSMenu *font_menu)
{
	MainMenuAddMissingCommandModifier([font_menu itemWithTitle:@"Show Colors"]);
	MainMenuAddMissingCommandModifier([font_menu itemWithTitle:@"Copy Style"]);
	MainMenuAddMissingCommandModifier([font_menu itemWithTitle:@"Paste Style"]);
}

NSMenuItem *MainMenuCreateFormatMenuItem()
{
	NSMenuItem *format_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"Format"
		action:nil
		keyEquivalent:@""];
	NSMenu *format_menu = [[NSMenu alloc] initWithTitle:@"Format"];

	NSMenuItem *font_menu_item = [format_menu
		addItemWithTitle:@"Font"
		action:nil
		keyEquivalent:@""];

	NSFontManager *font_manager = [NSFontManager sharedFontManager];
	NSMenu *font_menu = [font_manager fontMenu:YES];
	[format_menu
		setSubmenu:font_menu
		forItem:font_menu_item];

	MainMenuFixFontMenuKeyEquivalentModifierMask(font_menu);

	NSMenuItem *text_menu_item = [format_menu
		addItemWithTitle:@"Text"
		action:nil
		keyEquivalent:@""];
	NSMenu *text_menu = [[NSMenu alloc] initWithTitle:@"Text"];
	[format_menu
		setSubmenu:text_menu
		forItem:text_menu_item];

	[text_menu
		addItemWithTitle:@"Align Left"
		action:@selector(alignLeft:)
		keyEquivalent:@"{"];

	[text_menu
		addItemWithTitle:@"Center"
		action:@selector(alignCenter:)
		keyEquivalent:@"|"];

	[text_menu
		addItemWithTitle:@"Justify"
		action:@selector(alignJustified:)
		keyEquivalent:@""];

	[text_menu
		addItemWithTitle:@"Align Right"
		action:@selector(alignRight:)
		keyEquivalent:@"}"];

	[text_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *writing_direction_menu_item = [text_menu
		addItemWithTitle:@"Writing Direction"
		action:nil
		keyEquivalent:@""];
	NSMenu *writing_direction_menu = [[NSMenu alloc]
		initWithTitle:@"Writing Direction"];
	[text_menu
		setSubmenu:writing_direction_menu
		forItem:writing_direction_menu_item];

	[writing_direction_menu
		addItemWithTitle:@"Paragraph"
		action:nil
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:@"\tDefault"
		action:@selector(makeBaseWritingDirectionNatural:)
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:@"\tLeft to Right"
		action:@selector(makeBaseWritingDirectionLeftToRight:)
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:@"\tRight to Left"
		action:@selector(makeBaseWritingDirectionRightToLeft:)
		keyEquivalent:@""];

	[writing_direction_menu addItem:[NSMenuItem separatorItem]];

	[writing_direction_menu
		addItemWithTitle:@"Selection"
		action:nil
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:@"\tDefault"
		action:@selector(makeTextWritingDirectionNatural:)
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:@"\tLeft to Right"
		action:@selector(makeTextWritingDirectionLeftToRight:)
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:@"\tRight to Left"
		action:@selector(makeTextWritingDirectionRightToLeft:)
		keyEquivalent:@""];

	[text_menu addItem:[NSMenuItem separatorItem]];

	[text_menu
		addItemWithTitle:@"Show Ruler"
		action:@selector(toggleRuler:)
		keyEquivalent:@""];

	NSMenuItem *copy_ruler_menu_item = [text_menu
		addItemWithTitle:@"Copy Ruler"
		action:@selector(copyRuler:)
		keyEquivalent:@"c"];
	[copy_ruler_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagControl];

	NSMenuItem *paste_ruler_menu_item = [text_menu
		addItemWithTitle:@"Paste Ruler"
		action:@selector(pasteRuler:)
		keyEquivalent:@"v"];
	[paste_ruler_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagControl];

	[format_menu_item setSubmenu:format_menu];

	[writing_direction_menu release];
	[text_menu release];
	// [font_menu release];
	[format_menu release];

	return format_menu_item;
}

NSMenuItem *MainMenuCreateViewMenuItem()
{
	NSMenuItem *view_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"View"
		action:nil
		keyEquivalent:@""];
	NSMenu *view_menu = [[NSMenu alloc] initWithTitle:@"View"];

	NSMenuItem *show_toolbar_menu_item = [view_menu
		addItemWithTitle:@"Show Toolbar"
		action:@selector(toggleToolbarShown:)
		keyEquivalent:@"t"];
	[show_toolbar_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];

	[view_menu
		addItemWithTitle:@"Customize Toolbar…"
		action:@selector(runToolbarCustomizationPalette:)
		keyEquivalent:@""];

	[view_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *show_sidebar_menu_item = [view_menu
		addItemWithTitle:@"Show Sidebar"
		action:@selector(toggleSidebar:)
		keyEquivalent:@"s"];
	[show_sidebar_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagControl];

	NSMenuItem *enter_full_screen_menu_item = [view_menu
		addItemWithTitle:@"Enter Full Screen"
		action:@selector(toggleFullScreen:)
		keyEquivalent:@"f"];
	[enter_full_screen_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagControl];

	[view_menu_item setSubmenu:view_menu];

	[view_menu release];

	return view_menu_item;
}

NSMenuItem *MainMenuCreateWindowMenuItem()
{
	NSMenuItem *window_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"Window"
		action:nil
		keyEquivalent:@""];
	NSMenu *window_menu = [[NSMenu alloc] initWithTitle:@"Window"];

	[window_menu
		addItemWithTitle:@"Minimize"
		action:@selector(performMiniaturize:)
		keyEquivalent:@"m"];

	[window_menu
		addItemWithTitle:@"Zoom"
		action:@selector(performZoom:)
		keyEquivalent:@""];

	[window_menu addItem:[NSMenuItem separatorItem]];

	[window_menu
		addItemWithTitle:@"Bring All to Front"
		action:@selector(arrangeInFront:)
		keyEquivalent:@""];

	[window_menu_item setSubmenu:window_menu];

	[window_menu release];

	return window_menu_item;
}

NSMenuItem *MainMenuCreateHelpMenuItem()
{
	NSMenuItem *help_menu_item = [[NSMenuItem alloc]
		initWithTitle:@"Help"
		action:nil
		keyEquivalent:@""];
	NSMenu *help_menu = [[NSMenu alloc] initWithTitle:@"Help"];

	NSString *help_title = [MainMenuGetApplicationName()
		stringByAppendingString:@" Help"];
	[help_menu
		addItemWithTitle:help_title
		action:@selector(showHelp:)
		keyEquivalent:@"?"];

	[help_menu_item setSubmenu:help_menu];

	[help_menu release];

	return help_menu_item;
}
