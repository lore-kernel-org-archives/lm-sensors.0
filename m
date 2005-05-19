From: elenstev@mesatop.com (Steven Cole)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-Id: <200504191741.57626.elenstev@mesatop.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050419043938.GA23724@kroah.com> <200504191704.48976.elenstev@mesatop.com> <Pine.LNX.4.58.0504191627420.2274@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191627420.2274@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>, Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tuesday 19 April 2005 05:38 pm, Linus Torvalds wrote:
> 
> On Tue, 19 Apr 2005, Steven Cole wrote:
> > 
> > I wasn't complaining about the 4 minutes, just the lack of feedback
> > during the majority of that time.  And most of it was after the last
> > patching file message.
> 
> That should be exactly the thing that the new "read-tree -m" fixes.
> 
> Before, when you read in a new tree (which is what you do when you update
> to somebody elses version), git would throw all the cached information
> away, and so you'd end up doing a "checkout-cache -f -a" that re-wrote
> every single checked-out file, followed by "update-cache --refresh" that
> then re-created the cache for every single file.
> 
> With the new read-tree, the same sequence (assuming you have the "-m"  
> flag to tell read-tree to merge the cache information) will now only write
> out and re-check the files that actually changed due to the update or
> merge.
> 
> So that last phase should go from minutes to seconds - instead of checking
> 17,000+ files, you'd end up checking maybe a few hundred for most "normal"
> updates.
> 
> For example, updating all the way from the git root (ie plain 2.6.12-rc2)  
> to the current head, only 577 files have changed, and the rest (16,740)
> should never be touched at all.
> 
> You can see why doing just the 577 instead of the full 17,317 might speed
> things up a bit ;)
> 
> 		Linus

Cool.  Petr, I hope this works like this with your tools tomorrow.

> 
> PS. Of course, right now it probably does make sense to waste some time
> occasionally, and run "fsck-cache $(cat .git/HEAD)" every once in a while.
> Just in case..
> 
> 
Sounds like a good thing to schedule for $WEEHOUR.

Steven
