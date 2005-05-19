From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 4/15] arch: update device attribute
Message-Id: <25381867050517034045502624@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---
-------------- next part --------------
 arm/common/amba.c        |    2 +-
 arm/kernel/ecard.c       |   12 ++++++------
 arm26/kernel/ecard.c     |   10 +++++-----
 ia64/sn/kernel/tiocx.c   |    4 ++--
 parisc/kernel/drivers.c  |    2 +-
 ppc/kernel/pci.c         |    2 +-
 ppc/syslib/ocp.c         |    2 +-
 ppc/syslib/of_device.c   |    2 +-
 ppc64/kernel/of_device.c |    2 +-
 ppc64/kernel/pci.c       |    2 +-
 ppc64/kernel/vio.c       |    4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-arch.diff
Type: text/x-patch
Size: 10965 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050517/f479e927/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-arch.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
