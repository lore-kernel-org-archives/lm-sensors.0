From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH 2.6] Credit James Bolt in w83l785ts
Message-Id: <20040211203718.67607d40.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I forgot to give the credit he deserves to James Bolt for testing the
latest w83l785ts driver changes. Here is a patch that fixes that, if you
would like to enqueue it for future inclusion.

Thanks.

--- linux-2.6.3-rc2/drivers/i2c/chips/w83l785ts.c.orig	2004-02-10 14:24:34.000000000 +0100
+++ linux-2.6.3-rc2/drivers/i2c/chips/w83l785ts.c	2004-02-11 09:51:51.000000000 +0100
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


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
