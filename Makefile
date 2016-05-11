PO := $(wildcard license/license.*.po)
LICENSES := $(PO:.po=.txt)
VERSION=FIXME

all: skelcd/license.tar.gz

skelcd/license.tar.gz: $(LICENSES) | license/TEMPLATE
	cd license && tar --owner=root --group=root -czf ../$@ no-acceptance-needed *.txt

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
