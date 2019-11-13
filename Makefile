all : full.png theme.png color.png

pdfs : example-full.pdf example-theme.pdf example-color.pdf

%.png : example-%.pdf
	convert $^ tmp-$@
	montage tmp-$(basename $@)-*.png -geometry +2+4 $@

example-color.tex : example_template.tex beamercolorthemeyellowjacket.sty beamerthemeatlanta.sty
	sed -e "s/XCOLORX/yellowjacket/" -e "s/XTHEMEX/default/" $< > $@

example-full.tex : example_template.tex beamercolorthemeyellowjacket.sty beamerthemeatlanta.sty
	sed -e "s/XCOLORX/yellowjacket/" -e "s/XTHEMEX/atlanta/" $< > $@

example-theme.tex : example_template.tex beamercolorthemeyellowjacket.sty beamerthemeatlanta.sty
	sed -e "s/XCOLORX/default/" -e "s/XTHEMEX/atlanta/" $< > $@

example-%.pdf : example-%.tex
	pdflatex $<
	bibtex $(basename $<)
	pdflatex $<
	pdflatex $<

clean :
	${RM} example-*.tex *.pdf tmp-*.png *.out *.snm *.toc *.aux *.bbl *.blg *.log *.nav *.dvi
