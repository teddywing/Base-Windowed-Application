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
	NSMenu *application_menu = [[NSMenu alloc]
		initWithTitle:NSLocalizedString(
			@"Application",
			@"Application menu title."
		)];

	NSString *about_title = [NSString
		stringWithFormat:NSLocalizedString(@"About %@", @"About menu item."),
		MainMenuGetApplicationName()];
	NSMenuItem *about_menu_item = [application_menu
		addItemWithTitle:about_title
		action:@selector(orderFrontStandardAboutPanel:)
		keyEquivalent:@""];
	[about_menu_item setTarget:NSApp];

	[application_menu addItem:[NSMenuItem separatorItem]];

	[application_menu
		addItemWithTitle:NSLocalizedString(
			@"Preferences",
			@"Preferences menu item."
		)
		action:nil
		keyEquivalent:@","];

	[application_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *services_menu_item = [application_menu
		addItemWithTitle:@"Services"
		action:nil
		keyEquivalent:@""];
	NSMenu *services_menu = [[NSMenu alloc]
		initWithTitle:NSLocalizedString(
			@"Services",
			@"Services menu title."
		)];
	[application_menu
		setSubmenu:services_menu
		forItem:services_menu_item];
	[NSApp setServicesMenu:services_menu];

	[application_menu addItem:[NSMenuItem separatorItem]];

	NSString *hide_title = [NSString
		stringWithFormat:NSLocalizedString(@"Hide %@", @"Hide menu item."),
		MainMenuGetApplicationName()];
	NSMenuItem *hide_menu_item = [application_menu
		addItemWithTitle:hide_title
		action:@selector(hide:)
		keyEquivalent:@"h"];
	[hide_menu_item setTarget:NSApp];

	NSMenuItem *hide_others_menu_item = [application_menu
		addItemWithTitle:NSLocalizedString(
			@"Hide Others",
			@"Hide Others menu item."
		)
		action:@selector(hideOtherApplications:)
		keyEquivalent:@"h"];
	[hide_others_menu_item setTarget:NSApp];
	[hide_others_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];

	[application_menu
		addItemWithTitle:NSLocalizedString(
			@"Show All",
			@"Show All menu item."
		)
		action:nil
		keyEquivalent:@""];

	[application_menu addItem:[NSMenuItem separatorItem]];

	NSString *quit_title = [NSString
		stringWithFormat:NSLocalizedString(@"Quit %@", @"Quit menu item."),
		MainMenuGetApplicationName()];
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
	NSMenu *file_menu = [[NSMenu alloc]
		initWithTitle:NSLocalizedString(
			@"File",
			@"File menu title."
		)];

	[file_menu
		addItemWithTitle:NSLocalizedString(
			@"New",
			@"New menu item."
		)
		action:@selector(newDocument:)
		keyEquivalent:@"n"];

	[file_menu
		addItemWithTitle:NSLocalizedString(
			@"Open…",
			@"Open… menu item."
		)
		action:@selector(openDocument:)
		keyEquivalent:@"o"];

	[file_menu addItem:[NSMenuItem separatorItem]];

	[file_menu
		addItemWithTitle:NSLocalizedString(
			@"Close",
			@"Close menu item."
		)
		action:@selector(performClose:)
		keyEquivalent:@"w"];

	[file_menu
		addItemWithTitle:NSLocalizedString(
			@"Save…",
			@"Save… menu item."
		)
		action:@selector(saveDocument:)
		keyEquivalent:@"s"];

	NSMenuItem *save_as_menu_item = [file_menu
		addItemWithTitle:NSLocalizedString(
			@"Save As…",
			@"Save As… menu item."
		)
		action:@selector(saveDocumentAs:)
		keyEquivalent:@"s"];
	[save_as_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagShift];

	[file_menu
		addItemWithTitle:NSLocalizedString(
			@"Revert to Saved",
			@"Revert to Saved menu item."
		)
		action:@selector(revertDocumentToSaved:)
		keyEquivalent:@"r"];

	[file_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *page_setup_menu_item = [file_menu
		addItemWithTitle:NSLocalizedString(
			@"Page Setup…",
			@"Page Setup… menu item."
		)
		action:@selector(runPageLayout:)
		keyEquivalent:@"p"];
	[page_setup_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagShift];

	[file_menu
		addItemWithTitle:NSLocalizedString(
			@"Print…",
			@"Print… menu item."
		)
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
	NSMenu *edit_menu = [[NSMenu alloc]
		initWithTitle:NSLocalizedString(
			@"Edit",
			@"Edit menu title."
		)];

	[edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Undo",
			@"Undo menu item."
		)
		action:@selector(undo:)
		keyEquivalent:@"z"];

	[edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Redo",
			@"Redo menu item."
		)
		action:@selector(redo:)
		keyEquivalent:@"Z"];

	[edit_menu addItem:[NSMenuItem separatorItem]];

	[edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Cut",
			@"Cut menu item."
		)
		action:@selector(cut:)
		keyEquivalent:@"x"];

	[edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Copy",
			@"Copy menu item."
		)
		action:@selector(copy:)
		keyEquivalent:@"c"];

	[edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Paste",
			@"Paste menu item."
		)
		action:@selector(paste:)
		keyEquivalent:@"v"];

	NSMenuItem *paste_and_match_style_menu_item = [edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Paste and Match Style",
			@"Paste and Match Style menu item."
		)
		action:@selector(pasteAsPlainText:)
		keyEquivalent:@"V"];
	[paste_and_match_style_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];

	[edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Delete",
			@"Delete menu item."
		)
		action:@selector(delete:)
		keyEquivalent:@""];

	[edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Select All",
			@"Select All menu item."
		)
		action:@selector(selectAll:)
		keyEquivalent:@"a"];

	[edit_menu addItem:[NSMenuItem separatorItem]];

	// Find menu.
	NSMenuItem *find_menu_item = [edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Find",
			@"Find menu item."
		)
		action:nil
		keyEquivalent:@""];
	NSMenu *find_menu = [[NSMenu alloc]
		initWithTitle:@"Find"];
	[edit_menu
		setSubmenu:find_menu
		forItem:find_menu_item];

	NSMenuItem *find_ellipsis_menu_item = [find_menu
		addItemWithTitle:NSLocalizedString(
			@"Find…",
			@"Find… menu item."
		)
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"f"];
	[find_ellipsis_menu_item setTag:NSTextFinderActionShowFindInterface];

	NSMenuItem *find_and_replace_menu_item = [find_menu
		addItemWithTitle:NSLocalizedString(
			@"Find and Replace…",
			@"Find and Replace… menu item."
		)
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"f"];
	[find_and_replace_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];
	[find_and_replace_menu_item setTag:NSTextFinderActionShowReplaceInterface];

	NSMenuItem *find_next_menu_item = [find_menu
		addItemWithTitle:NSLocalizedString(
			@"Find Next",
			@"Find Next menu item."
		)
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"g"];
	[find_next_menu_item setTag:NSTextFinderActionNextMatch];

	NSMenuItem *find_previous_menu_item = [find_menu
		addItemWithTitle:NSLocalizedString(
			@"Find Previous",
			@"Find Previous menu item."
		)
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"G"];
	[find_previous_menu_item setTag:NSTextFinderActionPreviousMatch];

	NSMenuItem *use_selection_for_find_menu_item = [find_menu
		addItemWithTitle:NSLocalizedString(
			@"Use Selection for Find",
			@"Use Selection for Find menu item."
		)
		action:@selector(performTextFinderAction:)
		keyEquivalent:@"e"];
	[use_selection_for_find_menu_item setTag:NSTextFinderActionSetSearchString];

	[find_menu
		addItemWithTitle:NSLocalizedString(
			@"Jump to Selection",
			@"Jump to Selection menu item."
		)
		action:@selector(centerSelectionInVisibleArea:)
		keyEquivalent:@"j"];

	// Spelling and Grammar menu.
	NSMenuItem *spelling_and_grammar_menu_item = [edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Spelling and Grammar",
			@"Spelling and Grammar menu item."
		)
		action:nil
		keyEquivalent:@""];
	NSMenu *spelling_and_grammar_menu = [[NSMenu alloc]
		initWithTitle:@"Spelling and Grammar"];
	[edit_menu
		setSubmenu:spelling_and_grammar_menu
		forItem:spelling_and_grammar_menu_item];

	[spelling_and_grammar_menu
		addItemWithTitle:NSLocalizedString(
			@"Show Spelling and Grammar",
			@"Show Spelling and Grammar menu item."
		)
		action:@selector(showGuessPanel:)
		keyEquivalent:@":"];
	// NSLog(@"modifierMask: %lu", [x keyEquivalentModifierMask]);

	[spelling_and_grammar_menu
		addItemWithTitle:NSLocalizedString(
			@"Check Document Now",
			@"Check Document Now menu item."
		)
		action:@selector(checkSpelling:)
		keyEquivalent:@";"];

	[spelling_and_grammar_menu addItem:[NSMenuItem separatorItem]];

	[spelling_and_grammar_menu
		addItemWithTitle:NSLocalizedString(
			@"Check Spelling While Typing",
			@"Check Spelling While Typing menu item."
		)
		action:@selector(toggleContinuousSpellChecking:)
		keyEquivalent:@""];

	[spelling_and_grammar_menu
		addItemWithTitle:NSLocalizedString(
			@"Check Grammar With Spelling",
			@"Check Grammar With Spelling menu item."
		)
		action:@selector(toggleGrammarChecking:)
		keyEquivalent:@""];

	[spelling_and_grammar_menu
		addItemWithTitle:NSLocalizedString(
			@"Correct Spelling Automatically",
			@"Correct Spelling Automatically menu item."
		)
		action:@selector(toggleAutomaticSpellingCorrection:)
		keyEquivalent:@""];

	// Substitutions menu.
	NSMenuItem *substitutions_menu_item = [edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Substitutions",
			@"Substitutions menu item."
		)
		action:nil
		keyEquivalent:@""];
	NSMenu *substitutions_menu = [[NSMenu alloc]
		initWithTitle:@"Substitutions"];
	[edit_menu
		setSubmenu:substitutions_menu
		forItem:substitutions_menu_item];

	[substitutions_menu
		addItemWithTitle:NSLocalizedString(
			@"Show Substitutions",
			@"Show Substitutions menu item."
		)
		action:@selector(orderFrontSubstitutionsPanel:)
		keyEquivalent:@""];

	[substitutions_menu addItem:[NSMenuItem separatorItem]];

	[substitutions_menu
		addItemWithTitle:NSLocalizedString(
			@"Smart Copy/Paste",
			@"Smart Copy/Paste menu item."
		)
		action:@selector(toggleSmartInsertDelete:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:NSLocalizedString(
			@"Smart Quotes",
			@"Smart Quotes menu item."
		)
		action:@selector(toggleAutomaticQuoteSubstitution:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:NSLocalizedString(
			@"Smart Dashes",
			@"Smart Dashes menu item."
		)
		action:@selector(toggleAutomaticDashSubstitution:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:NSLocalizedString(
			@"Smart Links",
			@"Smart Links menu item."
		)
		action:@selector(toggleAutomaticLinkDetection:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:NSLocalizedString(
			@"Data Detectors",
			@"Data Detectors menu item."
		)
		action:@selector(toggleAutomaticDataDetection:)
		keyEquivalent:@""];

	[substitutions_menu
		addItemWithTitle:NSLocalizedString(
			@"Text Replacement",
			@"Text Replacement menu item."
		)
		action:@selector(toggleAutomaticTextReplacement:)
		keyEquivalent:@""];

	NSMenuItem *transformations_menu_item = [edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Transformations",
			@"Transformations menu item."
		)
		action:nil
		keyEquivalent:@""];
	NSMenu *transformations_menu = [[NSMenu alloc]
		initWithTitle:@"Transformations"];
	[edit_menu
		setSubmenu:transformations_menu
		forItem:transformations_menu_item];

	[transformations_menu
		addItemWithTitle:NSLocalizedString(
			@"Make Upper Case",
			@"Make Upper Case menu item."
		)
		action:@selector(uppercaseWord:)
		keyEquivalent:@""];

	[transformations_menu
		addItemWithTitle:NSLocalizedString(
			@"Make Lower Case",
			@"Make Lower Case menu item."
		)
		action:@selector(lowercaseWord:)
		keyEquivalent:@""];

	[transformations_menu
		addItemWithTitle:NSLocalizedString(
			@"Capitalize",
			@"Capitalize menu item."
		)
		action:@selector(capitalizeWord:)
		keyEquivalent:@""];

	NSMenuItem *speech_menu_item = [edit_menu
		addItemWithTitle:NSLocalizedString(
			@"Speech",
			@"Speech menu item."
		)
		action:nil
		keyEquivalent:@""];
	NSMenu *speech_menu = [[NSMenu alloc]
		initWithTitle:@"Speech"];
	[edit_menu
		setSubmenu:speech_menu
		forItem:speech_menu_item];

	[speech_menu
		addItemWithTitle:NSLocalizedString(
			@"Start Speaking",
			@"Start Speaking menu item."
		)
		action:@selector(startSpeaking:)
		keyEquivalent:@""];

	[speech_menu
		addItemWithTitle:NSLocalizedString(
			@"Stop Speaking",
			@"Stop Speaking menu item."
		)
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
	NSMenu *format_menu = [[NSMenu alloc]
		initWithTitle:NSLocalizedString(
			@"Format",
			@"Format menu title."
		)];

	NSMenuItem *font_menu_item = [format_menu
		addItemWithTitle:NSLocalizedString(
			@"Font",
			@"Font menu item."
		)
		action:nil
		keyEquivalent:@""];

	NSFontManager *font_manager = [NSFontManager sharedFontManager];
	NSMenu *font_menu = [font_manager fontMenu:YES];
	[format_menu
		setSubmenu:font_menu
		forItem:font_menu_item];

	MainMenuFixFontMenuKeyEquivalentModifierMask(font_menu);

	NSMenuItem *text_menu_item = [format_menu
		addItemWithTitle:NSLocalizedString(
			@"Text",
			@"Text menu item."
		)
		action:nil
		keyEquivalent:@""];
	NSMenu *text_menu = [[NSMenu alloc]
		initWithTitle:@"Text"];
	[format_menu
		setSubmenu:text_menu
		forItem:text_menu_item];

	[text_menu
		addItemWithTitle:NSLocalizedString(
			@"Align Left",
			@"Align Left menu item."
		)
		action:@selector(alignLeft:)
		keyEquivalent:@"{"];

	[text_menu
		addItemWithTitle:NSLocalizedString(
			@"Center",
			@"Center menu item."
		)
		action:@selector(alignCenter:)
		keyEquivalent:@"|"];

	[text_menu
		addItemWithTitle:NSLocalizedString(
			@"Justify",
			@"Justify menu item."
		)
		action:@selector(alignJustified:)
		keyEquivalent:@""];

	[text_menu
		addItemWithTitle:NSLocalizedString(
			@"Align Right",
			@"Align Right menu item."
		)
		action:@selector(alignRight:)
		keyEquivalent:@"}"];

	[text_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *writing_direction_menu_item = [text_menu
		addItemWithTitle:NSLocalizedString(
			@"Writing Direction",
			@"Writing Direction menu item."
		)
		action:nil
		keyEquivalent:@""];
	NSMenu *writing_direction_menu = [[NSMenu alloc]
		initWithTitle:@"Writing Direction"];
	[text_menu
		setSubmenu:writing_direction_menu
		forItem:writing_direction_menu_item];

	[writing_direction_menu
		addItemWithTitle:NSLocalizedString(
			@"Paragraph",
			@"Paragraph menu item."
		)
		action:nil
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:NSLocalizedString(
			@"\tDefault",
			@"Default menu item."
		)
		action:@selector(makeBaseWritingDirectionNatural:)
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:NSLocalizedString(
			@"\tLeft to Right",
			@"Left to Right menu item."
		)
		action:@selector(makeBaseWritingDirectionLeftToRight:)
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:NSLocalizedString(
			@"\tRight to Left",
			@"Right to Left menu item."
		)
		action:@selector(makeBaseWritingDirectionRightToLeft:)
		keyEquivalent:@""];

	[writing_direction_menu addItem:[NSMenuItem separatorItem]];

	[writing_direction_menu
		addItemWithTitle:NSLocalizedString(
			@"Selection",
			@"Selection menu item."
		)
		action:nil
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:NSLocalizedString(
			@"\tDefault",
			@"Default menu item."
		)
		action:@selector(makeTextWritingDirectionNatural:)
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:NSLocalizedString(
			@"\tLeft to Right",
			@"Left to Right menu item."
		)
		action:@selector(makeTextWritingDirectionLeftToRight:)
		keyEquivalent:@""];

	[writing_direction_menu
		addItemWithTitle:NSLocalizedString(
			@"\tRight to Left",
			@"Right to Left menu item."
		)
		action:@selector(makeTextWritingDirectionRightToLeft:)
		keyEquivalent:@""];

	[text_menu addItem:[NSMenuItem separatorItem]];

	[text_menu
		addItemWithTitle:NSLocalizedString(
			@"Show Ruler",
			@"Show Ruler menu item."
		)
		action:@selector(toggleRuler:)
		keyEquivalent:@""];

	NSMenuItem *copy_ruler_menu_item = [text_menu
		addItemWithTitle:NSLocalizedString(
			@"Copy Ruler",
			@"Copy Ruler menu item."
		)
		action:@selector(copyRuler:)
		keyEquivalent:@"c"];
	[copy_ruler_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagControl];

	NSMenuItem *paste_ruler_menu_item = [text_menu
		addItemWithTitle:NSLocalizedString(
			@"Paste Ruler",
			@"Paste Ruler menu item."
		)
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
	NSMenu *view_menu = [[NSMenu alloc]
		initWithTitle:NSLocalizedString(
			@"View",
			@"View menu title."
		)];

	NSMenuItem *show_toolbar_menu_item = [view_menu
		addItemWithTitle:NSLocalizedString(
			@"Show Toolbar",
			@"Show Toolbar menu item."
		)
		action:@selector(toggleToolbarShown:)
		keyEquivalent:@"t"];
	[show_toolbar_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];

	[view_menu
		addItemWithTitle:NSLocalizedString(
			@"Customize Toolbar…",
			@"Customize Toolbar… menu item."
		)
		action:@selector(runToolbarCustomizationPalette:)
		keyEquivalent:@""];

	[view_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *show_sidebar_menu_item = [view_menu
		addItemWithTitle:NSLocalizedString(
			@"Show Sidebar",
			@"Show Sidebar menu item."
		)
		action:@selector(toggleSidebar:)
		keyEquivalent:@"s"];
	[show_sidebar_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagControl];

	NSMenuItem *enter_full_screen_menu_item = [view_menu
		addItemWithTitle:NSLocalizedString(
			@"Enter Full Screen",
			@"Enter Full Screen menu item."
		)
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
	NSMenu *window_menu = [[NSMenu alloc]
		initWithTitle:NSLocalizedString(
			@"Window",
			@"Window menu title."
		)];

	[window_menu
		addItemWithTitle:NSLocalizedString(
			@"Minimize",
			@"Minimize menu item."
		)
		action:@selector(performMiniaturize:)
		keyEquivalent:@"m"];

	[window_menu
		addItemWithTitle:NSLocalizedString(
			@"Zoom",
			@"Zoom menu item."
		)
		action:@selector(performZoom:)
		keyEquivalent:@""];

	[window_menu addItem:[NSMenuItem separatorItem]];

	[window_menu
		addItemWithTitle:NSLocalizedString(
			@"Bring All to Front",
			@"Bring All to Front menu item."
		)
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
	NSMenu *help_menu = [[NSMenu alloc]
		initWithTitle:NSLocalizedString(
			@"Help",
			@"Help menu title."
		)];

	NSString *help_title = [NSString
		stringWithFormat:NSLocalizedString(@"%@ Help", @"Help menu item."),
		MainMenuGetApplicationName()];
	[help_menu
		addItemWithTitle:help_title
		action:@selector(showHelp:)
		keyEquivalent:@"?"];

	[help_menu_item setSubmenu:help_menu];

	[help_menu release];

	return help_menu_item;
}
