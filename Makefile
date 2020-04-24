tex_files = \
  pirouette_article.tex \
  pirouette_header.tex \
  pirouette_supplement.tex

all: pirouette_article.pdf

pirouette_article.pdf: Makefile $(tex_files)

pirouette_article.aux:
	pdflatex pirouette_header

pirouette_header.aux: 
	pdflatex pirouette_header

pirouette_header.log:
	pdflatex pirouette_header

pirouette_header.out:
	pdflatex pirouette_header

pirouette_supplement.aux:
	pdflatex pirouette_header

clean:
	rm -rf *.aux *.log *.out *.toc *.blg *.bbl

