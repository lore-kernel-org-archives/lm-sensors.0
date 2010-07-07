From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Jul 2010 19:32:21 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add support for NCT6775F
Message-Id: <20100707213221.28451ad0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100706222437.GA31051@ericsson.com>
In-Reply-To: <20100706222437.GA31051@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 7 Jul 2010 09:03:04 -0700, Guenter Roeck wrote:
> On Wed, Jul 07, 2010 at 11:53:27AM -0400, Jean Delvare wrote:
> > On Wed, 7 Jul 2010 08:29:55 -0700, Guenter Roeck wrote:
> > > On Wed, Jul 07, 2010 at 07:40:57AM -0400, Jean Delvare wrote:
> > > > Looks all sane, thanks for doing this. Shall I commit it, or should I
> > > > create a developer account and let you commit it? You already have an
> > > > account for the wiki, letting you commit to the repository is only one
> > > > configuration line away. So it's as you prefer.
> > >
> > > I really prefer the git way of doing things, meaning I prefer to have someone
> > > else have a close look at my code, and not commit my own junk myself.
> > > I also never worked with svn before, so I would be a bit concerned about
> > > screwing up the repository. Not really a good idea to make my first svn commit
> > > into a public repository.
> > 
> > SVN is really easy. It's almost the same as CVS if you've used CVS
> > before. And it's definitely easier than git.
> > 
> Easier than git - really ? After having worked with git for several years,
> I am still amazed (or, rather, I am more and more amazed) how easy and fast
> things are with git. Granted, one problem is that it is also very easy
> to screw up, which makes it very difficult to use with junior engineers ...

It is indeed very easy to screw up with git. It is also easy to put
your local repository in a state from which you don't know to recover.
It isn't surprising anyway, as git is much more powerful than SVN (let
alone CVS). With greater power comes greater ways to mess everything up.

Anyway, enough of this, I really don't have the time to discuss the
merits of git vs SVN, others have done it already. The only thing I
keep in mind is that you would have been more likely to contribute
directly if we were using git. If a lot of other developers start
claiming the same, then who knows...

> > > So let's keep it as is for now, and go ahead and commit. We can revisit that
> > > when you get tired having to deal with my patches.
> > 
> > I'm tired already ;)
> > 
> > Just joking. I'll be glad to review and commit your patches if such is
> > your desire.
>
> Let's at least stick with it for now.

I've just applied your patch, thanks for your contribution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
