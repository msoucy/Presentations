#!/usr/bin/make -f

PRESENTATIONS=$(wildcard */)
OUTDIR=output

all: presentations output

presentations: $(PRESENTATIONS)

$(PRESENTATIONS):
	$(MAKE) -C $@

output:
	mkdir -p $(foreach pres,$(PRESENTATIONS),$(OUTDIR)/$(pres))
	$(foreach pres,$(PRESENTATIONS),cp -r $(pres)/output/html/* $(OUTDIR)/$(pres);)

clean:
	rm -rf $(OUTDIR)

.PHONY: presentations
