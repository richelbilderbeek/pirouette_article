tex_files = \
  pirouette_article.tex \
  pirouette_header.tex \
  pirouette_supplement.tex

all: pirouette_article.pdf

pirouette_article.pdf: $(tex_files)
	chmod +x edit.sh
	chmod +x create_article.sh
	chmod +x view.sh
	aspell -t -c pirouette_article.tex
	aspell -t -c pirouette_supplement.tex
	./create_article.sh

clean:
	rm -rf *.aux *.log *.out *.toc *.blg *.bbl *.pdf

