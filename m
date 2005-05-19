From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913902818@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1079391390517@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.3, 2004/02/17 14:41:14-08:00, khali@linux-fr.org

[PATCH] I2C: Credit James Bolt in w83l785ts

I forgot to give the credit he deserves to James Bolt for testing the
latest w83l785ts driver changes. Here is a patch that fixes that.


 drivers/i2c/chips/w83l785ts.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:37:45 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:37:46 2004
@@ -12,6 +12,9 @@
  * Ported to Linux 2.6 by Wolfgang Ziegler <nuppla@gmx.at> and Jean Delvare
  * <khali@linux-fr.org>.
  *
+ * Thanks to James Bolt <james@evilpenguin.com> for benchmarking the read
+ * error handling mechanism.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or

