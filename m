From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 5/15] drivers/base -
Message-Id: <2538186705051703411ef34f38@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---
-------------- next part --------------
 base/dmapool.c       |    2 -
 base/interface.c     |    4 +-
 base/power/sysfs.c   |    4 +-
 block/ub.c           |    2 -
 char/hvcs.c          |   14 +++----
 char/mbcs.c          |    4 +-
 char/mwave/mwavedd.c |    2 -
 char/tpm/tpm.c       |    6 +--
 dio/dio-sysfs.c      |   10 ++---
 eisa/eisa-bus.c      |    4 +-
 i2c/chips/adm1021.c  |    6 +--
 i2c/chips/adm1025.c  |   28 +++++++-------
 i2c/chips/adm1026.c  |   98 +++++++++++++++++++++++++--------------------------
 13 files changed, 92 insertions(+), 92 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.0.diff
Type: text/x-patch
Size: 38747 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050517/9369942d/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.0.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
