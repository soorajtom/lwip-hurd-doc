
PHONY:
	ikiwiki --wikiname lwip-hurd \
	   --rebuild --verbose \
	   --plugin toc --plugin sidebar --plugin headinganchors --plugin img \
	   $(SRCDIR) $(DESTDIR)