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

My question here then: **can I make a HTML document that, when printed,
looks as good as a document produced using LaTeX?**

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
printed, will look as good as `article.cls` using LaTeX.

The file `print.css` is the beginnings of this CSS file. To use it, just
call Pandoc with the `-css` option, open the resulting HTML in any
modern browser[^browser] and print to PDF.

          pandoc input.md -so out.html -t HTML5 						     
             --bibliography="/path/to/BibTeX/library.bib"      
             --csl="/path/to/Styles/harvard3.csl"      
             --css="/path/to/CSS/print.css"     

I had considered using [Prince](http://www.princexml.com/) for this. The
default output from Prince looks *much* better, but I resisted for two
reasons: (1) I'd rather keep this as simple as possible. If I can do it
in CSS only, then great; (2) While Prince is free for non-commercial
use, you can't remove the (admitedly small) watermark from the page. If
I'm using this for production output, that isn't an option.

What works?
-----------

Nothing. Well, nearly nothing. I'm starting with the `Byword.css` file,
made available on the [Byword website](http://bywordapp.com/extras/index.html).
I've added:

- Times New Roman for the body; Helvetica for the headings.
- Auto-numbering of figures (using CSS counters)
- Better-than-default page margins (though work needed).


TODO
----

I'll work on these as/when I find time/motivation:

- Add automatic page numbering;
- Figure out page breaks in CSS;
- Place image caption above the image  
	- Doesn't look possible in CSS; requires placing `figcaption` above the 
	content, which would mean adjusting the HTML from Pandoc. 
- Improve page layout (find `article.cls` defaults)
- Investigate footnotes (probably impossible, but worth a check)
- Check that MathML output works.
- Check table support; improve table CSS.

Who's it for?
-------------

No-one. The CSS is messy, it's probably done better elsewhere, and right
now, doesn't even come close to replicating LaTeX functionality. I'm
writing this partly to improve my understanding of CSS and partly just to see if it's
possible. Check back in a few years!



[^browser]: Ideally, use Opera, and even better, [Opera
Next](http://www.opera.com/browser/next/) the beta version -- these are
some of the only browsers that support the `@page` CSS selector.
