From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <Pine.OSF.4.50.0301131008010.19607-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 12 Jan 2003, Mark Studebaker wrote:

> We have a vote from Ky?sti for branching.
> Albert suggested the same thing to me in an email.
> Pavel suggested abandoning CVS and doing everything in Linus' tree.
>
> I'm really reluctant to branch but it may be the only realistic way to do it
> unless somebody volunteers to do patches manually (and perpetually)

For 2.5 branch in CVS, I would use tags like lk2-5-53 to match it with
Linus's releases. And not bother with any KERNEL_VERSION there, if one
wants 2.5 she/he, will use the latest anyway.


> I guess we would do the 2.4 cleanup on the sensors side,
> then release 2.8.0, then branch?

Tag CVS before cleanup commit, I used LATEST-PRE-2.4.9-KERNEL for i2c.


-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
