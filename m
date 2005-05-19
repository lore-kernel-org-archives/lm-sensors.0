From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814513813@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814511367@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.15, 2004/04/02 11:05:14-08:00, mochel@digitalimplant.org

[PATCH] I2C: Fix check for DEBUG in i2c-ali1563


 drivers/i2c/busses/i2c-ali1563.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:44 2004
+++ b/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:44 2004
@@ -15,11 +15,6 @@
  *	This file is released under the GPLv2
  */
 
-#include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG 0
-#endif
-
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/pci.h>

