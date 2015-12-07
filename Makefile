skelcd/license.tar.gz:
	cd license && tar --owner=root --group=root -czf ../$@ no-acceptance-needed *.txt

clean:
	rm skelcd/license.tar.gz

.PHONY: clean
