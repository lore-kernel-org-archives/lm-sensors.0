From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 21:03:43 +0000
Subject: Re: [lm-sensors] [PATCH 79/79] hwmon: (it87) Fix vrm value range
Message-Id: <20120126220343.2da2f620@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Jan 2012 02:31:39 -0800, Guenter Roeck wrote:
> On Wed, Jan 25, 2012 at 05:17:24AM -0500, Jean Delvare wrote:
> > There are 3 different problems here.
> > 
> > Problem #1 is the bug in hwmon-vid which causes all unknown Intel
> > family 6 processors to use VRM 8.2, even though this is wrong on any
> > post-2007 CPU.
> 
> Working on fixing that. Looks like all the recent CPUs use VRD 11.0 or 11.1.
> There seem to be some supporting VRD 12.0, (the SandyBridge chips using the
> larger socket) but I did not find cpuid values for those.

There may be a problem with CPU models which can support an alternative
VID encoding for compatibility. I seem to recall that the early VRD
11.0 CPUs could also output VRD 10.x, but I could never find out how to
know when the actually did that.

> > Problem #2 is that unknown VRM for a recent CPU will only be notified
> > to the kernel log, which regular users don't read. Then you indeed get
> > a cpu0_vid value of 0. That's apparently what you were seeing on your
> > system. It would certainly be better to _not_ expose the VID value at
> > all if we don't know how to decode it.
>
> Actually, I have problem #1 on one board, and problem #3 on the other
> (the one with SandyBridge). vid reads 0xff on that board. On the other board,
> vid erroneously reports a voltage of 2.048V. I never thought about that
> until you brought it up.

2.050 V actually, this is 0x00 decoded as VRM 8.2. 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
