#!/bin/sh

# Make PDF via HTML and Prince
pandoc example.md -t HTML5 --bibliography="example.bib" --csl="style.csl" -s --smart --ascii --mathml --css="../print.css" > exampleHTML.html

prince exampleHTML.html


# Make PDF via LaTeX and pdflatex
pandoc example.md --bibliography="example.bib" --csl="style.csl" -s --smart --mathml --css="../print.css" -o exampleLaTeX.pdf

