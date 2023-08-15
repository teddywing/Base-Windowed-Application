SOURCES := $(shell find src -name '*.m')
OBJECTS := $(SOURCES:%.m=%.o)

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

.PHONY: clean
clean:
	rm $(OBJECTS)
