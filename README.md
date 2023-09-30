Base Windowed Application
=========================

A base template for Cocoa applications. These files provide the structure needed
to create a Cocoa application for Mac OS without Xcode or nib files. This
provides a minimal starting point without relying on Apple’s tools.

The build is done entirely using Make. Inspired by Jeff Johnson’s [Working
without a nib] blog series and [NiblessMenu] sample project, the main menu and
windows are all generated in code, not from nib files.


[Working without a nib]: http://lapcatsoftware.com/blog/2007/05/16/working-without-a-nib-part-1/
[NiblessMenu]: https://github.com/lapcat/NiblessMenu/


## Build a new Cocoa application
Copy the following files and folders into a new project directory:

* .gitignore
* Info.plist
* Internationalization/
* Makefile
* src/

If you aren’t creating a document-based application, don’t copy
`Document.{h,m}`, and delete the `CFBundleDocumentTypes` key from “Info.plist”.

Rename the application and update the sample text in “Makefile” and
“Info.plist”.

To build the application, run:

	$ make

This will build a “.app” bundle in the “build/” folder.


## License
Copyright © 2023 Teddy Wing. Licensed under the BSD Zero Clause License.
