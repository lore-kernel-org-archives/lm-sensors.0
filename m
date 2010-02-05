From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Feb 2010 08:12:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <20100205091214.2254f3e6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com>
	<20100204193712.22e8b6e7@hyperion.delvare>
	<201002041357.06748.sfking@fdwdc.com>
In-Reply-To: <201002041357.06748.sfking@fdwdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven King <sfking@fdwdc.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, 4 Feb 2010 13:57:06 -0800, Steven King wrote:
> On Thursday 04 February 2010 10:37:12 Jean Delvare wrote:
> > Could you please send a dump of your TMP102 chip, using i2cdump in word
> > mode?
> 
> sure, like so?
> 
> # ./i2cdump 0 0x4a w
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x4a, mode word
> Continue? [Y/n] y
>      0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
> 00: d90c b062 002d 004b c01a d006 0000 0000
> 08: d90c b062 002d 004b c01a d006 0000 0000
> 10: d90c b062 002d 004b c01a d006 0000 0000
> 18: d90c b062 002d 004b c01a d006 0000 0000
> 20: d90c b062 002d 004b c01a d006 0000 0000
> 28: d90c b062 002d 004b c01a d006 0000 0000
> 30: d90c b062 002d 004b c01a d006 0000 0000
> 38: d90c b062 002d 004b c01a d006 0000 0000
> 40: d90c b062 002d 004b c01a d006 0000 0000
> 48: d90c b062 002d 004b c01a d006 0000 0000
> 50: d90c b062 002d 004b c01a d006 0000 0000
> 58: d90c b062 002d 004b c01a d006 0000 0000
> 60: d90c b062 002d 004b c01a d006 0000 0000
> 68: d90c b062 002d 004b c01a d006 0000 0000
> 70: d90c b062 002d 004b c01a d006 0000 0000
> 78: d90c b062 002d 004b c01a d006 0000 0000
> 80: d90c b062 002d 004b c01a d006 0000 0000
> 88: d90c b062 002d 004b c01a d006 0000 0000
> 90: d90c b062 002d 004b c01a d006 0000 0000
> 98: d90c b062 002d 004b c01a d006 0000 0000
> a0: d90c b062 002d 004b c01a d006 0000 0000
> a8: d90c b062 002d 004b c01a d006 0000 0000
> b0: d90c b062 002d 004b c01a d006 0000 0000
> b8: d90c b062 002d 004b c01a d006 0000 0000
> c0: d90c b062 002d 004b c01a d006 0000 0000
> c8: d90c b062 002d 004b c01a d006 0000 0000
> d0: d90c b062 002d 004b c01a d006 0000 0000
> d8: d90c b062 002d 004b c01a d006 0000 0000
> e0: d10c b062 002d 004b c01a d006 0000 0000
> e8: d10c b062 002d 004b c01a d006 0000 0000
> f0: d10c b062 002d 004b c01a d006 0000 0000
> f8: d10c b062 002d 004b c01a d006 0000 0000
> # 

Exactly, thank you!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
