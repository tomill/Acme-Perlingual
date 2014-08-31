.PHONY: help

help:
	cat Makefile

run:
	PERL5OPT="-Mlib=extlib/lib/perl5 -Mlib=lib" extlib/bin/plackup --port 5656 -a example/app.psgi

rrun:
	PERL5OPT="-Mlib=extlib/lib/perl5 -Mlib=lib" extlib/bin/plackup --port 5656 -a example/app.psgi -R lib

setup:
	mkdir -p extlib
	PERL5OPT="-Mlib=${HOME}/perl5/lib/perl5" ~/perl5/bin/carton install --path extlib
