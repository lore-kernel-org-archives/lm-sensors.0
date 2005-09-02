From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Sep 2005 07:41:10 +0000
Subject: [lm-sensors] [patch-A 0/5] pc87360 SDA (sensor-dev-attr)
Message-Id: <20050902074101.5529241e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200508311827.j7VIRZ52006806@harpo.jimc.earth>
In-Reply-To: <200508311827.j7VIRZ52006806@harpo.jimc.earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> > This patch set reworks hwmon/pc87360.c to use the SENSOR_DEVICE_ATTR
> > idiom by Yani Ioannou, then uses the new member field to distinguish
> > which device is being accessed, eliminating the need for macro'd
> > repetition of a bunch of sysfs callback routines.
> >
> > These patches apply to 2.6.13 + 
> > http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c-2.6.13.patch
>
> sorry. should have mad this clear in the 1st post:
> patches incorporate Jean's feadback on last revision,
> so I ccd GregKH on them.

I did not receive any of these patches. Browsing the list archives
revealed 9 other patches from you that never made it to me, for a total
of 15. You really will have to find a solution that goes past my
greylisting for sending patches, else I will never be able to review
them nor have them applied.

Thanks,
-- 
Jean Delvare
