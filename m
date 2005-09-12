From: gregkh@suse.de (Greg KH)
Date: Mon, 12 Sep 2005 22:10:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: Update smsc47m1 head comment
Message-Id: <11265555193481@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Update smsc47m1 head comment

Update the head comment of the smsc47m1 driver to mention all the
supported devices.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0db9714a0ca2a1a36721a2e90fbfcbdf3d5ff117
tree 54925ad167934ff7a448a55ee0906b08eb78025e
parent b51f64c0de0355338480093abb35d5232f6d349a
author Jean Delvare <khali@linux-fr.org> Tue, 06 Sep 2005 21:21:54 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 09 Sep 2005 14:34:20 -0700

 drivers/hwmon/smsc47m1.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -2,8 +2,8 @@
     smsc47m1.c - Part of lm_sensors, Linux kernel modules
                  for hardware monitoring
 
-    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M13x and LPC47M14x
-    Super-I/O chips.
+    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x,
+    LPC47M15x and LPC47M192 Super-I/O chips.
 
     Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
     Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>

