From: Randy Dunlap <rdunlap@xenotime.net>
Date: Thu, 24 May 2012 18:08:21 +0000
Subject: Re: [lm-sensors] linux-next: Tree for May 24 (hwmon/sch56xx)
Message-Id: <4FBE7915.2000704@xenotime.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120524164915.fc6b1d90b75c50baab856280@canb.auug.org.au>
In-Reply-To: <20120524164915.fc6b1d90b75c50baab856280@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Hans de Goede <hdegoede@redhat.com>

On 05/23/12 23:49, Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20120523:




when CONFIG_WATCHDOG is not enabled:

drivers/built-in.o: In function `sch56xx_watchdog_register':
(.text+0x50711c): undefined reference to `watchdog_register_device'
drivers/built-in.o: In function `sch56xx_watchdog_unregister':
(.text+0x507171): undefined reference to `watchdog_unregister_device'

or when SCH56XX_COMMON=m:

ERROR: "watchdog_unregister_device" [drivers/hwmon/sch56xx-common.ko] undefined!
ERROR: "watchdog_register_device" [drivers/hwmon/sch56xx-common.ko] undefined!


-- 
~Randy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
