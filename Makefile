# Copyright (c) 2023  Teddy Wing
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
# WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


APP_NAME := Base\ Windowed\ Application

NBSP := $(shell perl -C -e 'print chr 0xfeff')
APP_NAME_NOSPACE := $(subst \ ,$(NBSP),$(APP_NAME))

SOURCES := $(shell find src -name '*.m')
OBJECTS := $(SOURCES:%.m=%.o)

LOCALIZABLE_STRINGS := $(shell find Internationalization -name Localizable.strings)

CFLAGS += -x objective-c
CFLAGS += -Wall -Werror
LDFLAGS += -framework Cocoa


.PHONY: all
all: app

%.o: %.m
	$(CC) \
		$(CFLAGS) \
		-c \
		$< \
		-o $@

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
