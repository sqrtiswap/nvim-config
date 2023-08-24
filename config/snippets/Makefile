LATEXCOMPILER = latexmk
LC_ARGS = -pdf -quiet
FILE =

CHECK_ZATHURA := $(shell command -v zathura > /dev/null)
CHECK_SKIM := $(shell brew list skim > /dev/null)
ifdef CHECK_ZATHURA
	VIEWER = ZATHURA
else CHECK_SKIM
	VIEWER = open -a Skim.app
else
	VIEWER = open
endif

.DEFAULT_GOAL := all

all: notes clean

paper:
	$(LATEXCOMPILER) $(LC_ARGS) ${FILE}.tex || (grep --color=always -PA5 "^! .*" ${FILE}.log; exit 1)
	@GREP_COLOR='01;34' grep --color=always -PA1 "Underfull\s*\w*" ${FILE}.log  || true;
	@GREP_COLOR='01;33' grep --color=always -PA1 "Overfull\s*\w*" ${FILE}.log  || true;
	@GREP_COLOR='01;33' grep --color=always -PA3 "^.*Warning" ${FILE}.log  || true;

supplemental:
	$(LATEXCOMPILER) $(LC_ARGS) supplemental.tex || (grep --color=always -PA5 "^! .*" supplemental.log; exit 1)
	@GREP_COLOR='01;34' grep --color=always -PA1 "Underfull\s*\w*" supplemental.log  || true;
	@GREP_COLOR='01;33' grep --color=always -PA1 "Overfull\s*\w*" supplemental.log  || true;
	@GREP_COLOR='01;33' grep --color=always -PA3 "^.*Warning" supplemental.log  || true;

clean:
	@$(LATEXCOMPILER) -c
	@rm -f *.dvi *.out *.aux *.log *.toc *.bbl *.blg *.ps

cleanall: clean
	@$(LATEXCOMPILER) -C
	@rm -f *Notes.bib
	@rm -f *.bbl
	@rm -f *.pdf

notes:
	$(LATEXCOMPILER) $(LC_ARGS) ${FILE}.tex

show: all
	$(VIEWER) ${FILE}.pdf

.PHONY: all clean cleanall notes paper show supplemental
