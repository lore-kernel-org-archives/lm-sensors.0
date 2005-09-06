From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Sep 2005 21:21:53 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: Update smsc47m1 head comment
Message-Id: <20050906212154.7313012e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Update the head comment of the smsc47m1 driver to mention all the
supported devices.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/smsc47m1.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47m1.c	2005-07-24 15:22:39.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47m1.c	2005-07-24 15:32:32.000000000 +0200
@@ -2,8 +2,8 @@
     smsc47m1.c - Part of lm_sensors, Linux kernel modules
                  for hardware monitoring
 
-    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M13x and LPC47M14x
-    Super-I/O chips.
+    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x,
+    LPC47M15x and LPC47M192 Super-I/O chips.
 
     Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
     Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>


-- 
Jean Delvare
