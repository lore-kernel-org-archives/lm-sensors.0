From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Apr 2007 13:17:55 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070420151755.1956ac3d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

On Sun, 8 Apr 2007 10:14:30 +0200, Jean Delvare wrote:
> On Tue, 3 Apr 2007 09:15:28 -0400, Mark M. Hoffman wrote:
> > IMPORTANT NOTE: next time we want to merge trunk changes out to the 3.0.0
> > branch, the merge command will be slightly different.  We must not use r4303
> > as the starting point, but rather r4355; otherwise we might duplicate some
> > changes.  So it is important to remember that we're synced up to r4355.  The
> > convention is to record that information in the commit log when the merge is
> > committed (which I did.)
> > 
> > If there are changes to trunk that don't make sense in the branch, then we can
> > handle that by "anti" cherry-picking them.  E.g. if r4360 is such a change,
> > we'll sync r4355:r4359 and then again r4361:whatever.
> 
> Another method would be to commit to both branches in parallel when a
> given change belongs to both branches. Looking at the changes you just
> merged, it seems that only a small amount of these were really needed
> in 3.0.0. All the changes to the kernel drivers, their documentation,
> lib/chips.*, prog/sensors/chips.* and sensors.conf.eg are for 2.10.x
> only. This doesn't leave that many areas where changes really need to
> be merged.
> 
> Also, parallel commit would have the benefit that we have a better
> history, and no merge delay. Opinion anyone?

As nobody objected, I am going that route from now on (and will catch
up with the few commits that already went in since the last merge.)
Whenever a change applies to both branches, we commit to both in
parallel, and we no longer merge. I only see benefits in doing things
this way. I expect both branches to diverge quickly anyway, except for
sensors-detect.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
