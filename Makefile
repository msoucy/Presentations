#!/usr/bin/make -f

PRESENTATIONS=BarcampD D evilC pgp python style
OUTDIR=output

all: clean presentations output

presentations: $(PRESENTATIONS)

$(PRESENTATIONS):
	mkdir -p $(OUTDIR)
	$(MAKE) -C $@

output: clean
	$(foreach pres,$(PRESENTATIONS),cp -r $(pres)/output/html $(OUTDIR)/$(pres);)

clean:
	rm -rf $(OUTDIR)

.PHONY: presentations $(PRESENTATIONS)
