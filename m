From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 05 Jun 2005 05:49:38 +0000
Subject: [lm-sensors] Query: davej-kernel-bug-generator-o-matic on sensor
Message-Id: <20050605034904.GC12860@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <cec4a19uu7fg2cahjfs59mr63tekithhsg@4ax.com>
In-Reply-To: <cec4a19uu7fg2cahjfs59mr63tekithhsg@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant:

* Grant Coady <grant_lkml@dodo.com.au> [2005-06-05 09:06:51 +1000]:
> kernel 2.6.12-rc5-mm2 all sensors devices modular, but only ISA bus:
> 
> root@sempro:~# /usr/local/bin/davej-kernel-bug-generator-o-matic |grep FATAL
> FATAL: Error inserting w83627ehf (/lib/modules/2.6.12-rc5-mm2a/kernel/drivers/i2c/chips/w83627ehf.ko): No such device
> FATAL: Error inserting smsc47m1 (/lib/modules/2.6.12-rc5-mm2a/kernel/drivers/i2c/chips/smsc47m1.ko): No such device
> FATAL: Error inserting pc87360 (/lib/modules/2.6.12-rc5-mm2a/kernel/drivers/i2c/chips/pc87360.ko): No such device
> FATAL: Error inserting smsc47b397 (/lib/modules/2.6.12-rc5-mm2a/kernel/drivers/i2c/chips/smsc47b397.ko): No such device
> root@sempro:~#
> 
> Does this indicate drivers that Yani's sysfs patch missed?
> Is anyone working on it?  

"FATAL: Error" is just modprobe telling you the module refused to load.

> Script from http://www.kernelplanet.org/ search for bug-generator-o-matic

I looked at Dave's script; its purpose is to find modules that *oops* when
they are loaded (presumably, without the actual H/W present).  So, I don't
think the errors you listed are actually problems at all (unless you happen
to *have* any of that H/W).

It's a nice little script though.  Thanks for pointing that out.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

