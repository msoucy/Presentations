#!/usr/bin/make

FILES:=${wildcard *.md}
OUTDIR:=output
CSS:=http://msoucy.me/theme/css/main.css

.PHONY: default slides pdf latex all clean

default: slides

slides: $(FILES:%.md=$(OUTDIR)/%/index.html)
pdf:    $(FILES:%.md=$(OUTDIR)/%/presentation.pdf)
latex:  $(FILES:%.md=$(OUTDIR)/%/presentation.tex)

all: clean slides pdf latex

PANDOC=pandoc $< -o $@

${OUTDIR}/%/index.html: %.md
	mkdir -p $(OUTDIR)/$*
	#${PANDOC} -t slidy -s --css $(CSS) --self-contained
	${PANDOC} -t slidy -s --css $(CSS)

${OUTDIR}/%/presentation.pdf: %.md
	mkdir -p $(OUTDIR)/$*
	${PANDOC} --toc

${OUTDIR}/%/presentation.tex: %.md
	mkdir -p $(OUTDIR)/$*
	${PANDOC}

${OUTDIR}:
	mkdir -p $(OUTDIR)

clean:
	rm -rf $(OUTDIR) &> /dev/null

# Images
${OUTDIR}/git-frc/pull-request.png: pull-request.png
	cp $< $@
${OUTDIR}/pgp/cc-88x31.png: cc-88x31.png
	cp $< $@

${OUTDIR}/git-frc/index.html: ${OUTDIR}/git-frc/pull-request.png
${OUTDIR}/pgp/index.html: ${OUTDIR}/git-frc/pull-request.png
