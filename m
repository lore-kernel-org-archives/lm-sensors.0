From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 2/15] drivers/base/core.c,
Message-Id: <253818670505170339187ebecd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

This patch adds the device_attribute paramerter to the
device_attribute store and show sysfs callback functions, and passes a
reference to the attribute when the callbacks are called.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---
-------------- next part --------------
 drivers/base/core.c    |    4 ++--
 include/linux/device.h |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.diff
Type: text/x-patch
Size: 1533 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050517/2da59aa5/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
