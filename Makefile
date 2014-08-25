#!/usr/bin/make -f

PRESENTATIONS=$(wildcard */)
OUTDIR=output

all: clean presentations output

presentations: $(PRESENTATIONS)

$(PRESENTATIONS):
	$(MAKE) -C $@

output: clean
	mkdir -p $(foreach pres,$(PRESENTATIONS),$(OUTDIR)/$(pres))
	$(foreach pres,$(PRESENTATIONS),cp -r $(pres)/output/html/* $(OUTDIR)/$(pres);)

clean:
	rm -rf $(OUTDIR)

.PHONY: presentations $(PRESENTATIONS)
