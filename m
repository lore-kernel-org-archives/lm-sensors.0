From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Sep 2006 19:25:52 +0000
Subject: [lm-sensors] [PATCH 23/23] hwmon: Remove Yuan Mu's address
Message-Id: <20060924212552.84abbf97.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-remove-yuan-mu-address.patch

hwmon: Remove Yuan Mu's address

Yuan Mu no longer works at Winbond.

I wish to publicly thank Yuan for his help with Winbond hardware
monitoring chips support during the past 10 months.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/w83627ehf |    2 +-
 drivers/hwmon/w83627ehf.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/Documentation/hwmon/w83627ehf	2006-09-23 15:30:14.000000000 +0200
+++ linux-2.6.18/Documentation/hwmon/w83627ehf	2006-09-23 21:56:43.000000000 +0200
@@ -9,7 +9,7 @@
 
 Authors:
         Jean Delvare <khali at linux-fr.org>
-        Yuan Mu <Ymu at Winbond.com.tw>
+        Yuan Mu (Winbond)
         Rudolf Marek <r.marek at sh.cvut.cz>
 
 Description
--- linux-2.6.18.orig/drivers/hwmon/w83627ehf.c	2006-09-23 20:56:29.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/w83627ehf.c	2006-09-23 21:56:43.000000000 +0200
@@ -2,7 +2,7 @@
     w83627ehf - Driver for the hardware monitoring functionality of
                 the Winbond W83627EHF Super-I/O chip
     Copyright (C) 2005  Jean Delvare <khali at linux-fr.org>
-    Copyright (C) 2006  Yuan Mu <Ymu at Winbond.com.tw>,
+    Copyright (C) 2006  Yuan Mu (Winbond),
                         Rudolf Marek <r.marek at sh.cvut.cz>
                         David Hubbard <david.c.hubbard at gmail.com>
 

-- 
Jean Delvare

