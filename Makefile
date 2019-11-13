all : full.png theme.png color.png
	${RM} tmp-*.png *.out *.snm *.toc *.aux *.bbl *.blg *.log *.nav *.dvi

pdfs : example-full.pdf example-theme.pdf example-color.pdf

%.png : example-%.pdf
	convert $^ tmp-$@
	montage tmp-$(basename $@)-*.png -geometry +2+4 $@

example-%.pdf : example-%.tex beamerthemeatlanta.sty beamercolorthemeyellowjacket.sty
	pdflatex $<
	bibtex $(basename $<)
	pdflatex $<
	pdflatex $<

clean :
	${RM} *.pdf tmp-*.png *.out *.snm *.toc *.aux *.bbl *.blg *.log *.nav *.dvi
