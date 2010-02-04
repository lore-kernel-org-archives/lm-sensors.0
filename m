From: Steven King <sfking@fdwdc.com>
Date: Thu, 04 Feb 2010 21:57:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <201002041357.06748.sfking@fdwdc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com> <20100204193712.22e8b6e7@hyperion.delvare>
In-Reply-To: <20100204193712.22e8b6e7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thursday 04 February 2010 10:37:12 Jean Delvare wrote:
> Hi Steven,
>
> On Wed, 3 Feb 2010 17:23:49 -0800, Steven King wrote:
> > The TI TMP102 is similar to the lm75.  It differs from the lm75 by having
> > a 16 bit conf register and the temp registers have a minimum resolution
> > of 12bits; the extended conf register can select 13 bit resolution (which
> > this driver does) and also change the update rate (which this driver
> > currently doesn't use).
> >
> > Signed-off-by: Steven King <sfking@fdwdc.com>
> > ---
> >
> > Driver for the TI TMP102.
>
> Could you please send a dump of your TMP102 chip, using i2cdump in word
> mode?

sure, like so?

# ./i2cdump 0 0x4a w
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x4a, mode word
Continue? [Y/n] y
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: d90c b062 002d 004b c01a d006 0000 0000
08: d90c b062 002d 004b c01a d006 0000 0000
10: d90c b062 002d 004b c01a d006 0000 0000
18: d90c b062 002d 004b c01a d006 0000 0000
20: d90c b062 002d 004b c01a d006 0000 0000
28: d90c b062 002d 004b c01a d006 0000 0000
30: d90c b062 002d 004b c01a d006 0000 0000
38: d90c b062 002d 004b c01a d006 0000 0000
40: d90c b062 002d 004b c01a d006 0000 0000
48: d90c b062 002d 004b c01a d006 0000 0000
50: d90c b062 002d 004b c01a d006 0000 0000
58: d90c b062 002d 004b c01a d006 0000 0000
60: d90c b062 002d 004b c01a d006 0000 0000
68: d90c b062 002d 004b c01a d006 0000 0000
70: d90c b062 002d 004b c01a d006 0000 0000
78: d90c b062 002d 004b c01a d006 0000 0000
80: d90c b062 002d 004b c01a d006 0000 0000
88: d90c b062 002d 004b c01a d006 0000 0000
90: d90c b062 002d 004b c01a d006 0000 0000
98: d90c b062 002d 004b c01a d006 0000 0000
a0: d90c b062 002d 004b c01a d006 0000 0000
a8: d90c b062 002d 004b c01a d006 0000 0000
b0: d90c b062 002d 004b c01a d006 0000 0000
b8: d90c b062 002d 004b c01a d006 0000 0000
c0: d90c b062 002d 004b c01a d006 0000 0000
c8: d90c b062 002d 004b c01a d006 0000 0000
d0: d90c b062 002d 004b c01a d006 0000 0000
d8: d90c b062 002d 004b c01a d006 0000 0000
e0: d10c b062 002d 004b c01a d006 0000 0000
e8: d10c b062 002d 004b c01a d006 0000 0000
f0: d10c b062 002d 004b c01a d006 0000 0000
f8: d10c b062 002d 004b c01a d006 0000 0000
# 

-- 
Steven King -- sfking at fdwdc dot com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
