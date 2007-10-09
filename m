From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 20:24:07 +0000
Subject: Re: [lm-sensors] [ANNOUNCE] superiotool -- Detect Super I/Os,
Message-Id: <20071009222407.7573aad4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071008013540.GB12533@greenwood>
In-Reply-To: <20071008013540.GB12533@greenwood>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 9 Oct 2007 21:16:22 +0200, Uwe Hermann wrote:
> On Tue, Oct 09, 2007 at 08:22:54PM +0200, Jean Delvare wrote:
> > No, I didn't go that far. My concern was simply that strncpy is
> > misused. strncpy doesn't null-terminate the string it copies, so you
> > end up passing an invalid string to printf.
> 
> Ah, yes, that's likely the reason for random junk the the end of the
> version number some people have noticed.

Yes it is.

> > I have a simple fix using atoi instead of the ugly strncpy/strlen mix
> > you have:
> > 
> >  superiotool.c |    7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > --- superiotool.orig/superiotool.c	2007-10-09 19:48:15.000000000 +0200
> > +++ superiotool/superiotool.c	2007-10-09 19:53:43.000000000 +0200
> > @@ -170,12 +170,7 @@ void probing_for(const char *vendor, con
> >  
> >  static void print_version(void)
> >  {
> > -	char tmp[80];
> > -
> > -	strncpy((char *)&tmp,
> > -		(const char *)&SUPERIOTOOL_VERSION[6],
> > -		strlen(SUPERIOTOOL_VERSION) - 8);
> > -	printf("superiotool r%s\n", (char *)&tmp);
> > +	printf("superiotool r%d\n", atoi(&SUPERIOTOOL_VERSION[6]));
> 
> Yeah, that was my first thought, but IIRC atoi() is deprecated in favor
> of strotol(), or at least it doesn't detect any errors (according to the
> manpage), which strtol() does. Btw, atoi() has to ignore random non-digit

No, atoi() isn't deprecated. It indeed doesn't detect errors, but OTOH
what kind of error do you expect, and how would you handle it?

> junk at the end of the string, is it guaranteed to do that in all
> implementations (different libc's or platforms, e.g. *BSD, Solaris, etc)?

I think so, but I haven't tested it.

> Also, _if_ the svn revision number gets too big, atoi()/strtol() will
> "truncate" it (yes, this is more a theoretical issue, won't happen
> anytime soon).

You mean, if the svn revision exceeds 2147483647? Come on.

> > don't you use arbitrary version numbers as every other projects do?
> 
> We don't do tarball releases, so arbitrary 0.x version numbers aren't
> that useful, and...

Doing no tarball releases is probably not a good idea to start with.
This will give your tool a bad visibility. Human-friendly version
numbers give packagers an idea of what changes are going in. With SVN
revision numbers, you can't tell a maintenance update from a complete
rewrite.

> > This is much more valuable than SVN revision numbers, and much easier
> > to maintain than what you're trying to do.
> 
> ...we want svn revisions as version number in order to be able to
> exactly match a bug to a certain svn revision (and also to match dump
> outputs to svn revisions).
> 
> Svn revision numbers are (if the solution works correctly) completely
> maintenance-free, you don't have to change a single line of code, and

Maintenance-free until you add a new source file to the project.

> the number will be increased automatically upon every commit. A lot
> easier than "manual" version number updates (which you'll forget often).
> 
> FWIW, it looks like this proposal is the best so far, so we'll probably
> use it: http://linuxbios.org/pipermail/linuxbios/2007-October/025551.html
> It gathers the svn version at build time (thus makes 'svnversion' a
> build requirement, but we can live with that). Other than that it does
> all we want, I think.

I had been thinking about this, yes. If you really want to use the SVN
revision number as the version, and if you really don't want to release
tarballs of your project, then that's the way to go.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
