From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 05 Jun 2005 01:07:12 +0000
Subject: [lm-sensors] Query: davej-kernel-bug-generator-o-matic on sensor
Message-Id: <cec4a19uu7fg2cahjfs59mr63tekithhsg@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi gang,

kernel 2.6.12-rc5-mm2 all sensors devices modular, but only ISA bus:

root@sempro:~# /usr/local/bin/davej-kernel-bug-generator-o-matic |grep FATAL
FATAL: Error inserting w83627ehf (/lib/modules/2.6.12-rc5-mm2a/kernel/drivers/i2c/chips/w83627ehf.ko): No such device
FATAL: Error inserting smsc47m1 (/lib/modules/2.6.12-rc5-mm2a/kernel/drivers/i2c/chips/smsc47m1.ko): No such device
FATAL: Error inserting pc87360 (/lib/modules/2.6.12-rc5-mm2a/kernel/drivers/i2c/chips/pc87360.ko): No such device
FATAL: Error inserting smsc47b397 (/lib/modules/2.6.12-rc5-mm2a/kernel/drivers/i2c/chips/smsc47b397.ko): No such device
root@sempro:~#

Does this indicate drivers that Yani's sysfs patch missed?
Is anyone working on it?  

Script from http://www.kernelplanet.org/ search for bug-generator-o-matic

grep = .config:
http://scatter.mine.nu/test/boxen/sempro/sempro-config-2.6.12-rc5-mm2a.gz

--Grant.

