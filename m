From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 31 Aug 2005 21:06:14 +0000
Subject: [lm-sensors] [patch-A 0/5] pc87360 SDA (sensor-dev-attr) callbacks
Message-Id: <4315FF82.4070700@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200508311827.j7VIRZ52006806@harpo.jimc.earth>
In-Reply-To: <200508311827.j7VIRZ52006806@harpo.jimc.earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:

>This patch set reworks hwmon/pc87360.c to use the SENSOR_DEVICE_ATTR
>idiom by Yani Ioannou, then uses the new member field to distinguish
>which device is being accessed, eliminating the need for macro'd
>repetition of a bunch of sysfs callback routines.
>
>These patches apply to 2.6.13 + 
>
>http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c-2.6.13.patch
>
>
>  
>
sorry. should have mad this clear in the 1st post:
patches incorporate Jean's feadback on last revision,
so I ccd GregKH on them.

