LINGUAS = \
	cs \
	de \
	es \
	fr \
	hu \
	it \
	ja \
	nl \
	pl \
	pt_BR \
	ru \
	uk \
	zh_CN \
	zh_TW
# ko not at 100%

LICENSES := $(LINGUAS:%=license/license.%.txt)

all: skelcd/license.tar.gz

skelcd/license.tar.gz: $(LICENSES) | license/TEMPLATE
	cd license && tar --owner=root --group=root -czf ../$@ no-acceptance-needed *.txt

clean:
	rm skelcd/license.tar.gz
	rm $(LICENSES)

license/TEMPLATE.pot: license/TEMPLATE
	txt2po -P $< $@

%.txt: %.po
	po2txt --progress=none $< $@

%.po: license/TEMPLATE.pot
	msgmerge -U --previous $@ $< && touch $@

.SUFFIXES = .po .txt
.PHONY: clean
