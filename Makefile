tex_files = \
  pirouette_article.tex \
  pirouette_header.tex \
  pirouette_supplement.tex

all: pirouette_article.pdf

pirouette_article.pdf: $(tex_files) pirouette_header.bib
	chmod +x edit.sh
	chmod +x create_article.sh
	chmod +x view.sh
	Rscript scripts/create_figure_2.R
	Rscript scripts/fix_tables.R
	./create_article.sh


spell_check:
	aspell -t -c pirouette_article.tex
	aspell -t -c pirouette_supplement.tex

count_words:
	cp pirouette_article.tex tmp_pirouette_article.tex
	# Get rid of the dollars in the code
	sed -i 's/pir_params.experiments..1...inference_model./pir_params_experiments[[1]]_inference_model_/g' tmp_pirouette_article.tex
	sed -i 's/pir_params.twinning_params.sim_twin_tree_fun/pir_params_twinning_params_sim_twin_tree_fun/g' tmp_pirouette_article.tex
	texcount tmp_pirouette_article.tex
	texcount tmp_pirouette_article.tex | egrep "Words in text"
	rm tmp_pirouette_article.tex


clean:
	rm -rf *.aux *.log *.out *.toc *.blg *.bbl *.pdf

