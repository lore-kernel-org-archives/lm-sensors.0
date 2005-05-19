From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: New sensors web site (was Re: 2nd mail archive?)
Message-Id: <FDmd72qq.1103018674.0379170.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41BDF25A.9030509@edgedesign.us>
In-Reply-To: <41BDF25A.9030509@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I like the idea of a wiki-style edit for web pages (at least only
> accessible for us).

If only a limited number of person can access it, I'm not sure it has an
interest to make it a wiki. Also, I wonder how you would create the
drivers tables as we have them now... Sounds a bit too complex to be
made with a wiki.

I am not opposed to the wiki concept, but I am not sure that all the web
site can be done that way. That said I can be convinced (let's just try
and see if we hit the limits or not). If there are more contributors to
the site that way (as opposed to hand-written HTML code under CVS) that
might be worth it, granted.

Also, we would need a place to manage board-specific configuration files.
I know someone started to work on this, don't know how far it went...
We need a place where we can store board-related info in a free but
consistent way (think of MBM's mobo list, more complete if possible).

http://mbm.livewiredev.com/mobolist.html

> Other things we will want:
>
> - CVS web browse

Sure, and if possible something a little bit more user-friendly than what
we had. Being able to download any revision of any file and getting
diffs between revisions are missing at the moment.

We might consider moving from CVS to Subversion. As far as I know it is
possible to convert CVS repositories without loss, and SVN allows things
CVS doesn't (such as renaming/moving files). This would suggest that
all contributors (not that many as far as I can tell) would need to
start using Subversion. Does it sound like a potential problem?

> - Support/ticket system

Again, something more user-friendly than what we have ATM would be
welcome. Original posters need to be able to add info to their ticket,
or the system is next to useless. Bugzilla? Or something else?

> - Mailing list (and web search)

Obviously...

> Anything else?

Nothing that I can think of.

> It probably isn't a bad time to try to roll in a new web design into the
> site.  I think things are rather too large right now (big fonts, big
> graphics, nav on left is a little funky, etc.).

Whatever we do, it has to rely on CSS. No more old-style
netscape-generated crappy html please. I've tried to clean things up
bit by bit in the last year, but redesigning the site from scratch
can't be bad.

Thanks,
--
Jean Delvare
