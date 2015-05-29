From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 29 May 2015 08:12:53 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip addresses 0x37 and 0x4f on DDC channels
Message-Id: <20150529101253.1073b8f8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150528175035.0127e5d1@endymion.delvare>
In-Reply-To: <20150528175035.0127e5d1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 May 2015 10:44:07 -0700, Guenter Roeck wrote:
> On Thu, May 28, 2015 at 05:50:35PM +0200, Jean Delvare wrote:
> > We already skip EDID addresses (0x50-0x57) by default on graphics card
> > I2C/DDC buses. Also skip 0x37 (DDC/CI) and 0x4f which was recently
> > reported as corrupting a laptop's display when probed.
> > 
> > This closes ticket #2392.
> > http://www.lm-sensors.org/ticket/2392
> 
> Looks good. Would it make sense to add a comment somewhere to the Linux kernel,
> listing addresses which should not be scanned as well as the reasons ?

Why not... Maybe in the "New drivers" section of
Documentation/hwmon/submitting-patches?

In fact it might be better to list the address ranges which can probed:
0x18-0x1f, 0x28-0x2f and 0x48-0x4f. Then there are 4 individual
addresses also probed by sensors-detect: 0x58, 0x5c, 0x73 and 0x77.
Ideally hwmon drivers would not probe any other address.

I'll prepare a patch, thanks for the suggestion.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
