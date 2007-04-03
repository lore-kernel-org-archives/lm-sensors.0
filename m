From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 03 Apr 2007 13:15:28 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070403131528.GB5464@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone:

> On Mon, 02 Apr 2007 10:17:41 +0200, Hans de Goede wrote:
> > I've been really busy lately with Fedora related "work", but I hope to find the 
> > time soon to start working on the dyn chip support. Most of the code is already 
> > tehre for the 2.x branch (written by my students). ANd my initial testing was good.
> > 
> > This leads me to the following questions:
> > 1) What cmdline magic must I pass to svn to get the 3.x branch when checking
> >     out?

* Jean Delvare <khali@linux-fr.org> [2007-04-02 13:36:49 +0200]:
> svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0

Correct.

> > 2) Do I need any cmdline magic to make sure a commit goes to the 3.x branch?
> >     (I've bad experiences with this with CVS, where a commit would go to the
> >      default branch even though I checkout another)
> 
> I've never done that, so I can't say for sure, but I think svn will
> remember what branch you checked out from and you don't need to add any
> parameter. Mark, can you please confirm this?

Correct.

> > 3) Is it ok for me to just start committing this, or should I post it for
> >     review here first?
> 
> I am usually committing directly, except when I am not sure myself that
> this is the right thing to do, in which case I post on the list first,
> and then sometimes commit the change, sometimes not. So it's up to you,
> for changes you are sure of or that have already been discussed, just
> commit them, and use the list if you think something needs to be
> discussed first. Remember, the whole idea of a separate 3.0.0 branch is
> that you can put all your changes there quickly.
> 
> Before you start really working on the 3.0.0 branch, we should sync it
> with the current trunk. Mark created the 3.0.0 branch quite some time
> ago, many fixes have gone into trunk since then, and I would hate to
> lose them. I don't know how this is done though. Mark, can you please
> take care of it? Maybe just kill the branch and recreate it?

I synced up the 3.0.0 branch this morning.  I would have just recreated it as
you suggest, except that I have 3 local copies of it, each with changes that
I haven't committed yet.  Merging it up to date was easier for me.

Here's what I did:

1. From which revision was the branch created?  The stop-on-copy arg tells svn
to show me logs going back to when the branch was created.  (A branch is nothing
more than a directory copy.)

	$ cd <working copy of 3.0.0 branch>
	$ svn log --stop-on-copy

2. What's the most recent revision on the trunk?

	$ cd <working copy of trunk>
	$ svn up

3. A merge is: find the differences between an old revision and a newer one,
apply those differences to the target branch.  (I specify the target branch
implicity in the following command, it's the branch of the CWD.)

	$ cd <working copy of 3.0.0 branch>
	$ svn merge -r 4303:4355 http://lm-sensors.org/svn/lm-sensors/trunk

> I also don't know how we are going to handle the later trunk changes,
> once 3.0.0 development is in progress. Some changes won't apply to the
> 3.0.0 branch (e.g. adding support for a new chip in libsensors) but
> many will.

IMPORTANT NOTE: next time we want to merge trunk changes out to the 3.0.0
branch, the merge command will be slightly different.  We must not use r4303
as the starting point, but rather r4355; otherwise we might duplicate some
changes.  So it is important to remember that we're synced up to r4355.  The
convention is to record that information in the commit log when the merge is
committed (which I did.)

If there are changes to trunk that don't make sense in the branch, then we can
handle that by "anti" cherry-picking them.  E.g. if r4360 is such a change,
we'll sync r4355:r4359 and then again r4361:whatever.

> Once real work starts on this branch, it should be documented on our
> Download page how to get the code, if we want testers. It would also be
> convenient to have nightly snapshots as we do for the trunk version.
> Axel, can this be done?

I don't think this is wanted just yet.  It's a good idea for later though.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
