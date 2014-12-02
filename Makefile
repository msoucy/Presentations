#!/usr/bin/make

FILES:=${wildcard *.md}
OUTDIR:=output
CSS:=/theme/css/main.css

.PHONY: default slides pdf latex all clean

default: slides

slides: $(FILES:%.md=$(OUTDIR)/%/index.html)
pdf:    $(FILES:%.md=$(OUTDIR)/%/presentation.pdf)
latex:  $(FILES:%.md=$(OUTDIR)/%/presentation.tex)

all: clean slides pdf latex

$(OUTDIR)/%/index.html: %.md $(OUTDIR)
	mkdir -p $(OUTDIR)/$*
	pandoc $< -o $@ -t slidy -s --css $(CSS)

$(OUTDIR)/%/presentation.pdf: %.md $(OUTDIR)
	mkdir -p $(OUTDIR)/$*
	pandoc $< -o $@ --toc

$(OUTDIR)/%/presentation.tex: %.md $(OUTDIR)
	mkdir -p $(OUTDIR)/$*
	pandoc $< -o $@

$(OUTDIR):
	mkdir -p $(OUTDIR)

clean:
	rm -rf $(OUTDIR) &> /dev/null
