From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jun 2008 09:47:21 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: (lm90) Enhancements for ADT7461
Message-Id: <20080615114721.1626e251@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1213374973-3262-1-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1213374973-3262-1-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nate,

On Fri, 13 Jun 2008 16:41:55 -0500, Nate Case wrote:
> On Fri, 2008-06-13 at 22:59 +0200, Jean Delvare wrote:
> > 
> > Could you possibly provide a dump of an ADT7461 chip in extended mode?
> > You can obtain it with i2cdump (part of the i2c-tools package). This
> > will help me test your changes.
> 
> Sure.  See below:
> (...)
> $ i2cdump -f 0 0x4c b (...)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0, address 0x4c, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 67 75 53 04 05 55 00 55 00 04 05 55 00 55 00 00    guS??U.U.??U.U..
> 10: 00 00 00 00 00 80 80 00 00 55 00 00 00 00 00 00    .....??..U......
> 20: 55 0a 01 00 00 00 00 00 00 c3 00 00 00 00 00 00    U??......?......
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41 51    ..............AQ

Thank you, I've added this one to my collection. This made me notice
that sensors-detect had a bug and wouldn't identify this chip properly.
It's fixed now.

As expected the current lm90 driver doesn't recognize this chip because
it's in extended resolution mode.

I'll review your patches this afternoon. Note that I already have 4
patches pending for the lm90 driver, so I might need to adjust your
patches so that they apply properly on top. In that case, I'll repost a
clean, complete patch set once we are done with the review and testing.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
