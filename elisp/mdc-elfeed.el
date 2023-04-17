(provide 'mdc-elfeed)

(use-package elfeed
  :ensure t)

(setq elfeed-feeds
      '(("https://slate.com/feeds/news-and-politics.rss" slate politics news frontpage)
        ("https://slate.com/feeds/culture.rss" slate culture frontpage)
        ("https://slate.com/feeds/technology.rss" slate technology frontpage)
        ("https://slate.com/feeds/business.rss" slate business)
        ("https://slate.com/feeds/human-interest.rss" slate human-interest)
        ("https://www.questionablecontent.net/QCRSS.xml" comics humor frontpage qc)
        ("https://thereader.mitpress.mit.edu//feed" culture mit-press-reader)
        ("https://xkcd.com/rss.xml" xkcd comics humor frontpage)
        ("https://feeds.feedburner.com/Metafilter" mefi culture frontpage)
        ("https://feeds.feedburner.com/AskMetafilter" askmefi cuture advice)
        ("http://www.antipope.org/charlie/blog-static/atom.xml" cstross blog)
        ("https://existentialcomics.com/rss.xml" philosophy comics frontpage)
        ("https://publicdomainreview.org/rss.xml" pdr culture frontpage)
        ("https://catandgirl.com/feed/" cat+girl humor comics)
        ("https://feeds.feedburner.com/PoorlyDrawnLines?format=xml" comics humor poorly)
        ("https://www.smbc-comics.com/comic/rss" comics humor cereal)
        ("https://emacsredux.com/atom.xml" blog emacs)
        ("http://blog.fogus.me/feed/" blog fogus programming)
        ("http://planet.lisp.org/rss20.xml" lisp)
        ("http://feeds.arstechnica.com/arstechnica/index/" ars news technology)
        ("http://rss.slashdot.org/Slashdot/slashdot" slashdot news technology)))

(setq-default elfeed-search-filter "@2-weeks-ago +unread +frontpage")
