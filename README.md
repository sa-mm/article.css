A CSS style for academic articles
---------------------------------

I write articles in
[Markdown](http://daringfireball.net/projects/markdown/) &mdash; a
lightweight, readable plain text markup language. I used to use
[MultiMarkdown](http://fletcherpenney.net/multimarkdown/), I now use
[Pandoc](http://johnmacfarlane.net/pandoc/). My typical workflow goes
something like:

 1. Write the draft in Markdown, using [Marked.app](http://markedapp.com/)
 	or HTML to preview the document;
 2. Convert to PDF using Pandoc (via LaTeX).
 
This works great, but recently I've been wondering if I need LaTeX at
all. Few journals will accept LaTeX (at least that I'm aware of); the
standard format is Microsoft Word or (occasionally) PDF. My only use for
LaTeX, therefore, is to produce good-looking PDF output. The question
here, then:

>**Can I make a HTML document that, when printed,
looks as good as a document produced using LaTeX?** 

The answer is almost certainly **no**, but I want to see how close I can
get.

Until recently I was reliant on LaTeX for it's BibTeX support. Since
Pandoc came out with support for
[citeproc-hs](http://gorgias.mine.nu/repos/citeproc-hs/), this is no
longer true. I can write citations in Pandoc syntax (see
[here](http://johnmacfarlane.net/pandoc/README.html#citations-1)) and
these are converted appropriately &mdash; whether I'm using Markdown,
PDF or DOCX (this works with just about [any citation
style](https://github.com/citation-style-language/styles)) you might
want).

Why?
----

- HTML preview is quicker than LaTeX preview.
- Single format for web/print.
- It's 2012.
- To learn CSS.
 

Features
--------

 - **Citations** (using the Pandoc syntax)
 - **Equations** (using LaTeX syntax, processed using MathJax)
 	- Auto-numbering of equations: just surround the equation with  
 	  `<span class="eq">` and `</span>`. (a future version of Pandoc
 	  make this unnecessary).
 - **Tables** (using the Pandoc syntax; automatic numbering throughout the document)
 - **Figures** (auto-numbering)
 - **Fonts**
 	- Times New Roman for the body; Helvetica for the headings (of course, 
   can be easily changed).
 - **Page layout**
 	- Better-than-default page margins (though more work needed &mdash; ideally would like 
   to replicate `article.cls` defaults).
    - Page numbers (currently only supported by [Prince](http://www.princexml.com))
   
The CSS will also recognise the following: 

 - A `<h2>` header with the content "Abstract" will be centred and in small-caps.
 - A `<h2>` header with the content "References" or "Bibliography" will be surrounded
   by page breaks.


Usage
-----

Just call `pandoc` with the `-css` option. I'm using the following script:

      #!/bin/sh
      pandoc *.md -t HTML5 --bibliography="/path/to/BibTeX/library.bib" 
      	--csl="/path/to/Styles/harvard3.csl" 
      	--css="/path/to/article.css"
      	-s --smart --ascii > draft.html
      
      prince draft.html
      open draft.pdf -a "/Applications/Skim.app"


Then open the resulting HTML file in a browser and print to PDF. I've
had best results with [Opera Next](http://www.opera.com/browser/next/),
the beta version of Opera. This currently has better support for the
`@page` CSS selector that Webkit or Gecko (although it's still very
limited and this is likely to change in future).

I'm also investigating using [Prince](http://www.princexml.com/) to convert
HTML to PDF. Prince has several advantages:

 1. The default output from Prince looks *much* better; 
 2. Prince supports more CSS `@page` features than Webkit, Presto (Opera) or Gecko (Firefox);
 3. Prince can be run from the command line, so doesn't require printing from the browser
 	(although [wkhtmltopdf](http://code.google.com/p/wkhtmltopdf/) does overcome this). 

The downsides are mainly cost. Prince is [extremely expensive](http://www.princexml.com/purchase/). 
There is a free, non-commercial version, but this embeds a small watermark on the first
page. Right now, Prince's advanced `@page` support is worth this limitation, but if other
browsers can improve their CSS3 support, this may change.

What's next?
------------

These are things I'd *like* to get working; I've no idea if they're actually possible.

- *Tables*
	- Support for long tables (i.e. tables with page breaks).
	- Table footnotes, automatically detected for rows beginning with
	  `footnote` or similar, using CSS selectors (currently 
	  [not possible](http://stackoverflow.com/questions/1520429/css-3-content-selector))
	- Decimal alignment (i.e. `dcolumn`) 
	- ~~Improve table CSS~~
- *Page layout*
	- Better page breaks using CSS;
	- Better default layout (based on `article.cls`)	
	- Footnotes (rather than endnotes)
	- ~~Fix line spacing around footnote markers~~
	- ~~Automatic page numbering~~
- *Images*
	- Place image caption above the image (doesn't look possible in CSS; 
	  requires placing `figcaption` above the content, which would mean 
	  adjusting the HTML from Pandoc)
- *Equations*
	- Better support for PrinceXML (MathJax isn't supported at present)
	- ~~Automatic numbering for equations~~
- *Misc*
	- Clean up the CSS
	- Write a better example file, with [less bacon](http://baconipsum.com/).
	- ~~Auto-recognise first `h2` titled "Abstract" and format accordingly.~~
	- ~~Recognise first paragraph following `h2#abstract` and increase margins~~
