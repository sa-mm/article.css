# Replacing LaTeX with Pandoc + CSS

What's this?
------------

I write academic articles in Markdown. I used to use
[MultiMarkdown](http://fletcherpenney.net/multimarkdown/); I now use
[Pandoc](http://johnmacfarlane.net/pandoc/). My typical workflow goes
something like:

 1. Write the draft in Markdown, using [Marked.app](http://markedapp.com/)
 	or HTML to preview the document;
 2. Convert to PDF using LaTeX (via Pandoc).
 
This is works great, but recently I've been wondering if I need the
LaTeX step at all. Since no journals/editors will accept LaTeX (at least
not that I'm aware of), I'm only using LaTeX to produce a good-looking
PDF document.

My question here then: 

>**Can I make a HTML document that, when printed,
looks as good as a document produced using LaTeX?** 

The answer is almost
certainly **no**, but I want to see how close I can get.

Until recently I was reliant on LaTeX for it's BibTeX support. Since
Pandoc came out with support for
[citeproc-hs](http://gorgias.mine.nu/repos/citeproc-hs/), this is no
longer true. I can write citations in Pandoc's syntax (see
[here](http://johnmacfarlane.net/pandoc/README.html#citations-1)) and
these are converted appropriately &mdash; whether I'm using Markdown,
PDF or DOCX. And this works with just about any citation style you want
(see the full list
[here](https://github.com/citation-style-language/styles)).

So, citation support is easy &mdash; just use Pandoc. The hard part is
writing a CSS file that will take a HTML5 file from Pandoc and, when
printed, will look as good as `article.cls` using LaTeX. The file
`print.css` is the beginnings of this CSS file.

Usage
-----

Just call `pandoc` the `-css` option. I'm using the following script:

     #!/bin/sh
     pandoc *.md -t HTML5 --bibliography="/Users/ewancarr/Documents/Work/Bibliography/BibTeX/library.bib" --csl="/Users/ewancarr/Dropbox/Code/Pandoc/Styles/harvard3.csl" -s --smart --ascii --css="/Users/ewancarr/Dropbox/Code/Projects/print.css/print.css" > draft.html
     
     prince draft.html
     open draft.pdf -a "/Applications/Skim.app"


Then print the resulting HTML file in a browser, and choose
"Save to PDF". I've gotten best results with [Opera
Next](http://www.opera.com/browser/next/), the beta version of Opera.
This currently has better support for the `@page` CSS selector that
Webkit or Gecko (although it's still very limited and this is likely to
change in future).

I'm also investigating using [Prince](http://www.princexml.com/) to convert
HTML to PDF. Prince has several advantages:

 1. The default output from Prince looks *much* better; 
 2. Prince supports more CSS `@page` features than Webkik, Presto (Opera) or Gecko (Firefox);
 3. Prince can be run from the command line, so doesn't require printing from the browser
 	(although [wkhtmltopdf](http://code.google.com/p/wkhtmltopdf/) does overcome this). 

The downsides are mainly cost. Prince is [extremely expensive](http://www.princexml.com/purchase/). 
There is a free, non-commercial version, but this embeds a small watermark on the first
page. Right now, Prince's advanced `@page` support is worth this limitation, but if other
browsers can improve their CSS3 support, this may change.

Features
--------

 - Citations (using the Pandoc syntax)
 - Equations (using LaTeX syntax, processed using MathJax)
 - Tables, with auto-numbering (using the Pandoc syntax)
 - Figures, with auto-numbering
 - Times New Roman for the body; Helvetica for the headings (of course, 
   can be easily changed).
 - Better-than-default page margins (though more work needed -- ideally would like 
   to replicate `article.cls` defaults).



What's next?
------------

- ~~Add automatic page numbering;~~ DONE.
- Figure out page breaks in CSS;
- Place image caption above the image (Doesn't look possible in CSS; 
  requires placing `figcaption` above the content, which would mean 
  adjusting the HTML from Pandoc)
- Better defaults for page layout (based on `article.cls`)
- Footnotes at the bottom of each page;
- Check that MathML output works.
- Improve table CSS.
- ~~Fix line spacing around footnote markers~~ DONE
- ???

Contribute!
-----------

In case it's not obvious enough, *I'm still learning CSS*, and don't
really know what I'm doing. All contributions are welcome!


