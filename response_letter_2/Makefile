all: response_letter_2.pdf

response_letter_2.pdf: README.md
	chmod +x edit.sh
	chmod +x view.sh
	aspell -c README.md
	pandoc README.md -o response_letter_2.pdf

clean:
	rm -f *.bak
