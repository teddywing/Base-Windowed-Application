APP_NAME := Base\ Windowed\ Application


SOURCES := $(shell find src -name '*.m')
OBJECTS := $(SOURCES:%.m=%.o)

LPROJS := $(shell ls Internationalization)

PRODUCT := build/Application


.PHONY: all
all: $(PRODUCT)

%.o: %.m
	$(CC) \
		-x objective-c \
		-c \
		$< \
		-o $@

$(PRODUCT): $(OBJECTS) | build
	$(CC) \
		-framework Cocoa \
		-o $@ \
		$^

build:
	mkdir -p build

build/$(APP_NAME).app: | build
	mkdir -p build/$(APP_NAME).app

build/$(APP_NAME).app/Contents: | build/$(APP_NAME).app
	mkdir -p build/$(APP_NAME).app/Contents

build/$(APP_NAME).app/Contents/MacOS: | build/$(APP_NAME).app/Contents
	mkdir -p build/$(APP_NAME).app/Contents/MacOS

build/$(APP_NAME).app/Contents/MacOS/$(APP_NAME): $(OBJECTS) \
| build/$(APP_NAME).app/Contents/MacOS
	$(CC) \
		-framework Cocoa \
		-o "${@}" \
		$^

# build/$(APP_NAME).app/Contents/Info.plist: Info.m4.plist \
# | build/$(APP_NAME).app/Contents
# 	m4 \
# 		--define='CF_BUNDLE_VERSION=$(CF_BUNDLE_VERSION)' \
# 		$< \
# 		> $@
build/$(APP_NAME).app/Contents/Info.plist: Info.plist \
| build/$(APP_NAME).app/Contents
	cp $< "${@}"

build/$(APP_NAME).app/Contents/Resources: | build/$(APP_NAME).app/Contents
	mkdir -p build/$(APP_NAME).app/Contents/Resources

# build/$(APP_NAME).app/Contents/Resources/%.lproj/Localizable.strings: \
# Internationalization/%.lproj/Localizable.strings \
# | build/$(APP_NAME).app/Contents/Resources
# 	mkdir -p $(dir "${@}")
# 	cp $< "${@}"

build/$(APP_NAME).app/Contents/Resources/%.lproj: \
Internationalization/%.lproj \
| build/$(APP_NAME).app/Contents/Resources
	cp $< "${@}"

.PHONY: app
app: \
build/$(APP_NAME).app/Contents/MacOS/$(APP_NAME) \
build/$(APP_NAME).app/Contents/Info.plist \
$(patsubst Internationalization/%,build/$(APP_NAME).app/Contents/Resources/%,$(LPROJS))

# $(subst Internationalization/,build/$(APP_NAME).app/Contents/Resources/,$(LOCALIZABLE_STRINGS))


.PHONY: genstrings
genstrings: Base.lproj/Localizable.strings

Base.lproj/Localizable.strings: $(SOURCES)
	genstrings -o Base.lproj $^

	mv $@ "$@.utf16"
	iconv --from-code=UTF-16 --to-code=UTF-8 "$@.utf16" > $@
	rm "$@.utf16"


.PHONY: clean
clean:
	rm $(OBJECTS)
