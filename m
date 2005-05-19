From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: About to release
Message-Id: <20030707163631.4dcc0636.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030707154107.556a1372.khali@linux-fr.org>
In-Reply-To: <20030707154107.556a1372.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'll retest sensors-detect tonight and let's take another
> day for testing and reviewing the docs.

Sounds OK. I'll test a fresh checkout on my four systems
(sensors-detect, drivers and sensors) this afternoon.

> We can give Phil the OK on Wednesday and he can release late in the
> week.(Phil likes releasing late in the week to avoid weekday load on
> his server)

That's OK for me. BTW I guess that the high load is caused by the
Freshmeat announcement, not by the release itself, so the release day
may be chosen freely I suppose.

If load is an issue, there are two major things that could be done to
limit it:

1* Use bzip2 instead of gzip to compress the release files. It should
reduce the network use by 25%. We can make both available if you think
there are still persons who can't handle bzip2-compressed files. In this
case, I think we can expect a 10% network use reduction.

2* Clean our HTML code. A simple HTML cleanup as the one I did for the
New Drivers page can reduce the page size by 2 to 3%. Using Style sheets
would probably reduce by much more than that, maybe up to 30 or 40%.
Also, we could stop using server-side includes and build the pages using
a simple Makefile. This would probably be less CPU-power consuming for
the web server. We could also use PNG instead of GIF for our pictures
(I'd expect a 20% size reduction).

BTW, 5 of our pages have this include:
  <!--#include virtual="test.cgi" -->
It seems to be a counter, but it doesn't work (displays: "0 hits since
July 23, 1998"). It's pretty lame isn't it? ;) I think we should either
fix the CGI (and rename it to something better than test.cgi) or remove
the includes (and delete the script). The question is, do we need a
counter?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
