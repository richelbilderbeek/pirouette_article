tex_files = \
  pirouette_article.tex \
  pirouette_header.tex \
  pirouette_supplement.tex

all: pirouette_article.pdf

pirouette_article.pdf: $(tex_files)
	./create_article.sh

clean:
	rm -rf *.aux *.log *.out *.toc *.blg *.bbl *.pdf

