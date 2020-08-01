# pirouette_article

Branch  |[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
--------|-------------------------------------------------------------------------------------------------------------------------------------------------------
`master`|[![Build Status](https://travis-ci.org/richelbilderbeek/pirouette_article.svg?branch=master)](https://travis-ci.org/richelbilderbeek/pirouette_article)

![](pics/qr_biorxiv.png)

Article about pirouette, by Bilderbeek, Laudanno and Etienne

 * [BioRxiv pre-print](https://biorxiv.org/cgi/content/short/2019.12.17.879098v1) (before processing feedback from reviewers)
 * [v1.3](https://github.com/richelbilderbeek/pirouette_article/releases/download/v1.3/pirouette_article.pdf)

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

