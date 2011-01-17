From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 17 Jan 2011 21:13:16 +0000
Subject: Re: [lm-sensors] driver for emc1023
Message-Id: <1295298796.9786.226.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D34960C.8070303@gmail.com>
In-Reply-To: <4D34960C.8070303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-01-17 at 15:50 -0500, Jean Delvare wrote:
> On Mon, 17 Jan 2011 12:39:32 -0800, Guenter Roeck wrote:
> > On Mon, 2011-01-17 at 14:18 -0500, Anish Patel wrote:
> > > here is the driver for the emc1023 and the makefile patch.
> > > i've spent a couple hours now trying to figure out how to create a patch 
> > > for a new file, and can't find anything.
> > > if someone would care to point me in the right direction i'll resubmit, 
> > > but at this point i am tired of trying to figure this out.
> > > Doc/SubmittingDrivers and SubmittingPatches is no help on how to do this.
> >
> > Nowadays, pretty much everyone uses git.
> 
> I very much doubt it.
> 
Ok, point taken.

> > Clone a new kernel tree from
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git.
> 
> You're suggesting Anish to download over 1 GB of kernel data history
> just to write one small patch?
> 
Guess so. Didn't really occur to me that might be a problem.

> 
> > Make your changes. Commit locally into your git repository. If
> > necessary, use "git rebase -i" to merge multiple commits into one when
> > you are ready to submit the driver.
> > 
> > Generate a patch file, for example for the most recent commit, with "git
> > format-patch -s HEAD~1".
> 
> Even me have never used these git commands. I doubt that pointing an
> inexperienced developer in that direction is going to work.
> 
Hey, even I learned to use it ;)

> If anything, quilt is one order of magnitude easier to deal with IMHO,
> and it doesn't require downloading anything Anish doesn't already have
> (short of quilt itself, but it's pretty small.)
> 
Fine with me too. For whatever reason, I never got it to work, though,
so I ended up sticking with git. Guess it is for the individual to
decide if git or quilt is easier to deal with ...

Cheers,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
