From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 07 Aug 2015 17:03:50 +0000
Subject: [lm-sensors] [hwmon:watchdog-next 11/19] drivers/watchdog/lpc18xx_wdt.c:126:14: sparse: symbol
Message-Id: <201508080133.jDW20mAc%fengguang.wu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-next
head:   738f09850b8d45002a5315b24b893f5aaf419079
commit: 98dbc95687cc28c6a7a502c1fc35b53df5d13fa5 [11/19] watchdog: NXP LPC18xx Watchdog Timer Driver
reproduce:
  # apt-get install sparse
  git checkout 98dbc95687cc28c6a7a502c1fc35b53df5d13fa5
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/watchdog/lpc18xx_wdt.c:126:14: sparse: symbol 'lpc18xx_wdt_get_timeleft' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
