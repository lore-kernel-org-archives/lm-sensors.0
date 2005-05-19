From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c/kernel i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c
Message-Id: <3E24983B.BA5B8C76@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E23647B.2070805@paradyne.com>
In-Reply-To: <3E23647B.2070805@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I thought we were going to change the refcounts 
from .inc_use to .owner _after_ the branch...

But if you can get the refcount changes into 2.4.21 then maybe we don't need
to branch at all?

Ky?sti M?lkki wrote:
> 
> On Tue, 14 Jan 2003, Mark Studebaker wrote:
> 
> > but it needs to compile outside kernel too.
> 
> Yes, but video4linux will still compile in kernel tree and use
> different i2c header files. Also I dropped .inc_use()
> completely, in favour of .owner that is common for 2.4 and 2.5.
> 
> This temporarily breaks non-CVS i2c code in kernel, but patches
> can be backported from 2.5.54+. Mkpatch should apply these too.
> 
> Once this is done, I would consider 2.8.0 release and sending patches
> for inclusion in 2.4.21.
> 
> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi
