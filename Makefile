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
	zh_CN \
	zh_TW

LICENSES := $(LINGUAS:%=license/license.%.txt)

all: skelcd/license.tar.gz

skelcd/license.tar.gz: $(LICENSES) | license/TEMPLATE
	cd license && tar --owner=root --group=root -czf ../$@ no-acceptance-needed *.txt

clean:
	rm skelcd/license.tar.gz
	rm $(LICENSES)

license/TEMPLATE.pot: license/TEMPLATE
	txt2po -P $< $@

%.txt: %.po license/TEMPLATE.pot
	po2txt --progress=none $< $@

.SUFFIXES = .po .txt
.PHONY: clean
