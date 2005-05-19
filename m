From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c/kernel i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c
Message-Id: <Pine.OSF.4.50.0301150119470.11865-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E23647B.2070805@paradyne.com>
In-Reply-To: <3E23647B.2070805@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 14 Jan 2003, Mark Studebaker wrote:

> I thought we were going to change the refcounts
> from .inc_use to .owner _after_ the branch...

Well, yes. I made the branch already for 2.4 with tag lk2-4.
I am just about to commit most of 2.5<->2.4 changes back to 2.4.

> But if you can get the refcount changes into 2.4.21 then maybe we
> don't need to branch at all?

I am optimistic, it is backported from 2.5.53-54 changes.
In 2.5.54+, the mentioned video4linux drivers were converted.
Without i2c, video4linux backporting can not proceed.
And i2c-proc used .owner in 2.3.37 already.

The branch is still useful.
I would like to push some changes to i2c interface during the 2.5
cycle, without worrying about 2.4 compatibility:
 - i2c-algo-biths
 - master_send/recv removal (issues with multi-master)
 - pass *client with i2c_transfer (have per-client speed)
 - master transmitter as slave receiver

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
