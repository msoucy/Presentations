#!/usr/bin/make

FILES:=${wildcard *.md}
OUTDIR:=output

.PHONY: default slides pdf latex all clean

default: slides

slides: $(FILES:%.md=$(OUTDIR)/%.html)
pdf:    $(FILES:%.md=$(OUTDIR)/%.pdf)
latex:  $(FILES:%.md=$(OUTDIR)/%.tex)

all: clean slides pdf latex

$(OUTDIR)/%.html: %.md $(OUTDIR)
	pandoc $< -o $@ -t slidy -s

$(OUTDIR)/%.pdf: %.md $(OUTDIR)
	pandoc $< -o $@ --toc

$(OUTDIR)/%.tex: %.md $(OUTDIR)
	pandoc $< -o $@

$(OUTDIR):
	mkdir -p $(OUTDIR)

clean:
	rm -rf $(OUTDIR) &> /dev/null
