.POSIX:
.SUFFIXES:
.PHONY: all clean install check

PROJECT   =advent-of-code-2025-tcl
VERSION   =01
PREFIX    =/usr/local
BUILDDIR ?=.build
EXE      ?=$(shell uname -s | awk '/Windows/ || /MSYS/ || /CYG/ { print ".exe" }')
FW_FILES  =$(shell echo *.tcl *.data)
FW_PROGS_R=\
    $(BUILDDIR)/aoc2025_Linux_x86_64.run \
    $(BUILDDIR)/aoc2025_Linux_i686.run \
    $(BUILDDIR)/aoc2025_Windows_NT_x86_64.exe \
    $(BUILDDIR)/aoc2025_Windows_NT_i686.exe

all: $(BUILDDIR)/aoc2025
clean:
	rm -f $(BUILDDIR)/aoc2025 $(FW_PROGS_R)
install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp $(BUILDDIR)/aoc2025 $(DESTDIR)$(PREFIX)/bin
check:
## -- BLOCK:freewrap --
$(BUILDDIR)/%$(EXE): %.tcl $(FW_FILES)
	freewrap-cc -o $@ $< $(FW_FILES)
$(BUILDDIR)/%_Linux_x86_64.run: %.tcl $(FW_FILES)
	freewrap-cc -o $@ -P Linux -M x86_64 $< $(FW_FILES)
$(BUILDDIR)/%_Linux_i686.run: %.tcl $(FW_FILES)
	freewrap-cc -o $@ -P Linux -M i686 $< $(FW_FILES)
$(BUILDDIR)/%_Windows_NT_x86_64.exe: %.tcl $(FW_FILES)
	freewrap-cc -o $@ -P Windows_NT -M x86_64 $< $(FW_FILES)
$(BUILDDIR)/%_Windows_NT_i686.exe: %.tcl $(FW_FILES)
	freewrap-cc -o $@ -P Windows_NT -M i686 $< $(FW_FILES)
release: $(FW_PROGS_R)
   ifneq ($(FW_PROGS_R),)
	gh release create v$(VERSION) $(FW_PROGS_R)
   endif
## -- BLOCK:freewrap --
