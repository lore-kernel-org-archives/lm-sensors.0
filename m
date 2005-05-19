From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <002801c49b4d$fb045a10$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> ----- Original Message ----- 
> From: "Jean Delvare" <khali@linux-fr.org>
> To: "Leif W" <warp-9.9@usa.net>
> Cc: <sensors@Stimpy.netroedge.com>
> Sent: Sunday, September 12, 2004 04:46
> Subject: Re: Support DB Entry 1770
>
> Most (if not all) of the docs in the lm_sensors2 CVS repository are
> targeted at 2.4 kernels. The reason is both historical (obviously) and
> technical (2.6 drivers are not part of the package).

Ahh, guess I found it confusing, as the source is in the 2.6 tree.  I
assumed it was all part of the same project.  Written by the same folks,
but not part of the LM Sensors project?  Or is it a 2.4 module being
compiled for a 2.6 kernel?

> But I agree that updating the docs as time permits would be great.
> Another approach would be to add chip documentation to the 2.6 kernel.

Either do one and make the other point to the first, or do both.
Whichever is possible or practical.  I am not very familiar with the LM
Sensors project, or with the kernel project from the point of view of a
patch submitter.  So sorry for any confusion.

> Care to provide this documentation update as a patch we could apply to
> the CVS repository? Thanks.

I'll do that, rewording and including your corrections.

> (BTW, I cannot possibly connect to the CVS repository for now, so
> someone else will have to apply the patch.)

As long as it gets there eventually.  :p

> As for me, I will propose my extra-debug patch (slightly cleaned up)
for
> inclusion into the 2.6 kernel. It helped us once, so it could prove to
> be valuable in the future as well.

I've applied that patch to my debian 2.6.8-5 source (noticed your was
2.6.9-rc1), and generated a new diff, and diffed the diffs, and line
numbers were off by one, but there was no stray code... so I assumed it
was a clean enough patch.  I've compiled with this, and seems to be
working fine.  The key point was for me to disable "Dalayed
Transactions" between ISA<->PCI.

I should test LM Sensors on my other systems as I get a chance: ASUS
K7V-T, ASUS A7N8X-Deluxe.  My P5A was rev 1.03, and I also have rev 1.04
and 1.06.  I also have K7V, and A7N8X boards, and may test them if I
don't sell them first.  These should all be very similar to my active
system boards though.

Leif


