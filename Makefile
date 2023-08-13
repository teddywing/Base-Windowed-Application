SOURCES := $(shell find src -name '*.m')
OBJECTS := $(SOURCES:%.m=%.o)

PRODUCT := Application


.PHONY: all
all: $(PRODUCT)

%.o: %.m
	$(CC) \
		-x objective-c \
		-c \
		$< \
		-o $@

$(PRODUCT): $(OBJECTS)
	$(CC) \
		-framework Cocoa \
		-o $@ \
		$^

.PHONY: clean
clean:
	rm $(OBJECTS)
