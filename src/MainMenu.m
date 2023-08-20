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

	// TODO: Undo and redo don't work.
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
	NSMenu *font_menu = [[NSMenu alloc] initWithTitle:@"Font"];
	[format_menu
		setSubmenu:font_menu
		forItem:font_menu_item];

	[font_menu
		addItemWithTitle:@"Show Fonts"
		action:@selector(orderFrontFontPanel:)
		keyEquivalent:@"t"];
	// TODO: target NSFontManager

	NSMenuItem *bold_menu_item = [font_menu
		addItemWithTitle:@"Bold"
		action:@selector(addFontTrait:)
		keyEquivalent:@"b"];
	[bold_menu_item setTag:NSAddTraitFontAction];
	// TODO: target NSFontManager

	[font_menu
		addItemWithTitle:@"Italic"
		action:@selector(addFontTrait:)
		keyEquivalent:@"i"];
	// TODO: target NSFontManager

	[font_menu
		addItemWithTitle:@"Underline"
		action:@selector(underline:)
		keyEquivalent:@"u"];

	[font_menu addItem:[NSMenuItem separatorItem]];

	[font_menu
		addItemWithTitle:@"Bigger"
		action:@selector(modifyFont:)
		keyEquivalent:@"+"];
	// TODO: target NSFontManager

	[font_menu
		addItemWithTitle:@"Smaller"
		action:@selector(modifyFont:)
		keyEquivalent:@"-"];
	// TODO: target NSFontManager

	[font_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *kern_menu_item = [font_menu
		addItemWithTitle:@"Kern"
		action:nil
		keyEquivalent:@""];
	NSMenu *kern_menu = [[NSMenu alloc] initWithTitle:@"Kern"];
	[font_menu
		setSubmenu:kern_menu
		forItem:kern_menu_item];

	[kern_menu
		addItemWithTitle:@"Use Default"
		action:@selector(useStandardKerning:)
		keyEquivalent:@""];

	[kern_menu
		addItemWithTitle:@"Use None"
		action:@selector(turnOffKerning:)
		keyEquivalent:@""];

	[kern_menu
		addItemWithTitle:@"Tighten"
		action:@selector(tightenKerning:)
		keyEquivalent:@""];

	[kern_menu
		addItemWithTitle:@"Loosen"
		action:@selector(loosenKerning:)
		keyEquivalent:@""];

	NSMenuItem *ligatures_menu_item = [font_menu
		addItemWithTitle:@"Ligatures"
		action:nil
		keyEquivalent:@""];
	NSMenu *ligatures_menu = [[NSMenu alloc] initWithTitle:@"Ligatures"];
	[font_menu
		setSubmenu:ligatures_menu
		forItem:ligatures_menu_item];

	[ligatures_menu
		addItemWithTitle:@"Use Default"
		action:@selector(useStandardLigatures:)
		keyEquivalent:@""];

	[ligatures_menu
		addItemWithTitle:@"Use None"
		action:@selector(turnOffLigatures:)
		keyEquivalent:@""];

	[ligatures_menu
		addItemWithTitle:@"Use All"
		action:@selector(useAllLigatures:)
		keyEquivalent:@""];

	NSMenuItem *baseline_menu_item = [font_menu
		addItemWithTitle:@"Baseline"
		action:nil
		keyEquivalent:@""];
	NSMenu *baseline_menu = [[NSMenu alloc] initWithTitle:@"Baseline"];
	[font_menu
		setSubmenu:baseline_menu
		forItem:baseline_menu_item];

	[baseline_menu
		addItemWithTitle:@"Use Default"
		action:@selector(unscript:)
		keyEquivalent:@""];

	[baseline_menu
		addItemWithTitle:@"Superscript"
		action:@selector(superscript:)
		keyEquivalent:@""];

	[baseline_menu
		addItemWithTitle:@"Subscript"
		action:@selector(subscript:)
		keyEquivalent:@""];

	[baseline_menu
		addItemWithTitle:@"Raise"
		action:@selector(raiseBaseline:)
		keyEquivalent:@""];

	[baseline_menu
		addItemWithTitle:@"Lower"
		action:@selector(lowerBaseline:)
		keyEquivalent:@""];

	[font_menu addItem:[NSMenuItem separatorItem]];

	[font_menu
		addItemWithTitle:@"Show Colors"
		action:@selector(orderFrontColorPanel:)
		keyEquivalent:@"C"];

	[font_menu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *copy_style_menu_item = [font_menu
		addItemWithTitle:@"Copy Style"
		action:@selector(copyFont:)
		keyEquivalent:@"c"];
	[copy_style_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];

	NSMenuItem *paste_style_menu_item = [font_menu
		addItemWithTitle:@"Paste Style"
		action:@selector(pasteFont:)
		keyEquivalent:@"v"];
	[paste_style_menu_item
		setKeyEquivalentModifierMask:
			NSEventModifierFlagCommand | NSEventModifierFlagOption];

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
	[font_menu release];
	[format_menu release];

	return format_menu_item;
}

NSMenuItem *MainMenuCreateViewMenuItem()
{
	return nil;
}

NSMenuItem *MainMenuCreateWindowMenuItem()
{
	return nil;
}

NSMenuItem *MainMenuCreateHelpMenuItem()
{
	return nil;
}
