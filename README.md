# pirouette_article

Branch  |[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
--------|-------------------------------------------------------------------------------------------------------------------------------------------------------
`master`|[![Build Status](https://travis-ci.org/richelbilderbeek/pirouette_article.svg?branch=master)](https://travis-ci.org/richelbilderbeek/pirouette_article)

![](pics/qr_biorxiv.png)

Article about pirouette, by Bilderbeek, Laudanno and Etienne.
This is the proper reference:

> Bilderbeek, RJC, Laudanno, G, Etienne, RS. Quantifying the impact of an inference model in Bayesian phylogenetics. Methods Ecol Evol. 2020; 00: 1– 8. https://doi.org/10.1111/2041-210X.13514

## Older versions

 * [BioRxiv pre-print v3](https://biorxiv.org/cgi/content/short/2019.12.17.879098v3)
 * [v1.3](https://github.com/richelbilderbeek/pirouette_article/releases/download/v1.3/pirouette_article.pdf)

## Data

Software              |DOI
----------------------|----------------
pirouette v1.6.4      |[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3969839.svg)](https://doi.org/10.5281/zenodo.3969839)
pirouette_article v1.3|[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3969845.svg)](https://doi.org/10.5281/zenodo.3969845)
pirouette_examples    |[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3970000.svg)](https://doi.org/10.5281/zenodo.3970000)

## Older versions

 * [BioRxiv pre-print v2](https://biorxiv.org/cgi/content/short/2019.12.17.879098v2)
 * [BioRxiv pre-print v1](https://biorxiv.org/cgi/content/short/2019.12.17.879098v1)

## FAQ

### How do you build the PDF for the article?

```
./scripts/create_article.sh
```

Because Overleaf removes the file permissions, add the right to execute with:

```
chmod +x scripts/create_article.sh
```

### How do you build the PDF for the response letter?

```
./scripts/create_response_letter.sh
```

Because Overleaf removes the file permissions, add the right to execute with:

```
chmod +x scripts/create_response_letter.sh
```

### How do you get the figures?

```
Rscript scripts/copy_figs_from_examples_to_here.R
```

The R scripts expects the `pirouette` examples to be in the same folder
as `pirouette_article` is. That is, it expects the following folder structure:

```
-+ [folder]
 |
 +--- pirouette_article
 |
 +--- pirouette_example_x
```

## References

 *  Bilderbeek, RJC, Laudanno, G, Etienne, RS. Quantifying the impact of an inference model in Bayesian phylogenetics. Methods Ecol Evol. 2020; 00: 1– 8. https://doi.org/10.1111/2041-210X.13514

