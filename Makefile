APP_NAME := Base\ Windowed\ Application

NBSP := $(shell perl -C -e 'print chr 0xfeff')
APP_NAME_NOSPACE := $(subst \ ,$(NBSP),$(APP_NAME))

SOURCES := $(shell find src -name '*.m')
OBJECTS := $(SOURCES:%.m=%.o)

LOCALIZABLE_STRINGS := $(shell find Internationalization -name Localizable.strings)

PRODUCT := build/Application

CFLAGS += -x objective-c
LDFLAGS += -framework Cocoa


.PHONY: all
all: $(PRODUCT)

%.o: %.m
	$(CC) \
		$(CFLAGS) \
		-c \
		$< \
		-o $@

$(PRODUCT): $(OBJECTS) | build
	$(CC) \
		$(LDFLAGS) \
		-o $@ \
		$^

build:
	mkdir -p build

build/$(APP_NAME_NOSPACE).app: | build
	mkdir -p build/$(APP_NAME_NOSPACE).app

build/$(APP_NAME_NOSPACE).app/Contents: | build/$(APP_NAME_NOSPACE).app
	mkdir -p build/$(APP_NAME_NOSPACE).app/Contents

build/$(APP_NAME_NOSPACE).app/Contents/MacOS: | build/$(APP_NAME_NOSPACE).app/Contents
	mkdir -p build/$(APP_NAME_NOSPACE).app/Contents/MacOS

build/$(APP_NAME_NOSPACE).app/Contents/MacOS/$(APP_NAME_NOSPACE): $(OBJECTS) \
| build/$(APP_NAME_NOSPACE).app/Contents/MacOS
	$(CC) \
		$(LDFLAGS) \
		-o "${@}" \
		$^

build/$(APP_NAME_NOSPACE).app/Contents/Info.plist: Info.plist \
| build/$(APP_NAME_NOSPACE).app/Contents
	cp $< "${@}"

build/$(APP_NAME_NOSPACE).app/Contents/Resources: | build/$(APP_NAME_NOSPACE).app/Contents
	mkdir -p build/$(APP_NAME_NOSPACE).app/Contents/Resources

build/$(APP_NAME_NOSPACE).app/Contents/Resources/%.lproj/Localizable.strings: \
Internationalization/%.lproj/Localizable.strings \
| build/$(APP_NAME_NOSPACE).app/Contents/Resources
	mkdir -p "$(dir ${@})"
	cp $< "${@}"

build/$(APP_NAME_NOSPACE).app/Contents/Resources/%.lproj: \
Internationalization/%.lproj \
| build/$(APP_NAME_NOSPACE).app/Contents/Resources
	cp -R $< "${@}"

# Application name does not include spaces.
ifeq ($(APP_NAME),$(APP_NAME_NOSPACE))
.PHONY: app
app: \
build/$(APP_NAME_NOSPACE).app/Contents/MacOS/$(APP_NAME_NOSPACE) \
build/$(APP_NAME_NOSPACE).app/Contents/Info.plist \
$(subst Internationalization/,build/$(APP_NAME_NOSPACE).app/Contents/Resources/,$(LOCALIZABLE_STRINGS))

# Application name does have spaces.
else
NOSPACE_BUNDLE_FILES = $(shell find build/$(APP_NAME_NOSPACE).app -type f)


build/$(APP_NAME).app: $(NOSPACE_BUNDLE_FILES)
	rsync -rupE build/$(APP_NAME_NOSPACE).app/ "${@}/"

build/$(APP_NAME).app/Contents/MacOS/$(APP_NAME): \
build/$(APP_NAME_NOSPACE).app/Contents/MacOS/$(APP_NAME_NOSPACE)
	cp -a "${<}" "${@}"
	rm -f build/$(APP_NAME).app/Contents/MacOS/$(APP_NAME_NOSPACE)

.PHONY: app
app: \
build/$(APP_NAME_NOSPACE).app/Contents/MacOS/$(APP_NAME_NOSPACE) \
build/$(APP_NAME_NOSPACE).app/Contents/Info.plist \
$(subst Internationalization/,build/$(APP_NAME_NOSPACE).app/Contents/Resources/,$(LOCALIZABLE_STRINGS)) \
build/$(APP_NAME).app \
build/$(APP_NAME).app/Contents/MacOS/$(APP_NAME)
endif


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
