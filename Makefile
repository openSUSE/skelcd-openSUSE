PO := $(wildcard license/license.*.po)
LICENSES := $(PO:.po=.txt)
VERSION=FIXME

all: skelcd/license.tar.gz

skelcd/license.tar.gz: $(LICENSES) | license/TEMPLATE
	[ -z "$$SOURCE_DATE_EPOCH" ] || rbopts="--mtime @$$SOURCE_DATE_EPOCH --format=gnu" ; \
	cd license && tar $$rbopts --owner=root --group=root -c no-acceptance-needed *.txt | gzip -n9 > ../$@

clean:
	rm -f skelcd/license.tar.gz $(LICENSES)

license/TEMPLATE.pot: license/TEMPLATE
	txt2po -P $< $@

%.txt: %.po
	po2txt --progress=none --threshold=100 $< $@
	@if [ -e $@ ]; then sed -i -e"s@#VERSION#@$(VERSION)@g" $@; fi

%.po: license/TEMPLATE.pot
	msgmerge -U --previous $@ $< && touch $@

.SUFFIXES = .po .txt
.PHONY: clean
