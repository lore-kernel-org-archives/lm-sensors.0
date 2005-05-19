From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 9/15] drivers/i2c/chips/w83781d.c -
Message-Id: <2538186705051703422834d321@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---
-------------- next part --------------
 i2c/chips/w83781d.c          |   52 +++++++++++++++++++++----------------------
 i2c/chips/w83l785ts.c        |    4 +--
 i2c/i2c-core.c               |    4 +--
 ieee1394/nodemgr.c           |   16 ++++++-------
 ieee1394/sbp2.c              |    2 -
 input/gameport/gameport.c    |    4 +--
 input/keyboard/atkbd.c       |    4 +--
 input/mouse/psmouse.h        |    4 +--
 input/serio/serio.c          |   16 ++++++-------
 macintosh/therm_adt746x.c    |    8 +++---
 macintosh/therm_pm72.c       |    4 +--
 macintosh/therm_windtunnel.c |    4 +--
 mca/mca-bus.c                |    4 +--
 message/fusion/mptscsih.c    |    2 -
 mmc/mmc_sysfs.c              |    2 -
 pci/hotplug/cpqphp_sysfs.c   |    4 +--
 pci/hotplug/shpchp_sysfs.c   |    4 +--
 pci/pci-sysfs.c              |    6 ++--
 pcmcia/ds.c                  |    4 +--
 pnp/card.c                   |    4 +--
 pnp/interface.c              |    8 +++---
 s390/block/dasd_devmap.c     |   10 ++++----
 s390/block/dcssblk.c         |   24 +++++++++----------
 23 files changed, 97 insertions(+), 97 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.4.diff
Type: text/x-patch
Size: 41377 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050517/9d256de0/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.4.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
