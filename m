From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:59 +0000
Subject: [lm-sensors] [PATCH 39/39] hwmon: Remove Yuan Mu's address
Message-Id: <11594838882449-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

hwmon: Remove Yuan Mu's address

Yuan Mu no longer works at Winbond.

I wish to publicly thank Yuan for his help with Winbond hardware
monitoring chips support during the past 10 months.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/hwmon/w83627ehf |    2 +-
 drivers/hwmon/w83627ehf.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/w83627ehf b/Documentation/hwmon/w83627ehf
index 1474e78..fae3b78 100644
--- a/Documentation/hwmon/w83627ehf
+++ b/Documentation/hwmon/w83627ehf
@@ -9,7 +9,7 @@ Supported chips:
 
 Authors:
         Jean Delvare <khali at linux-fr.org>
-        Yuan Mu <Ymu at Winbond.com.tw>
+        Yuan Mu (Winbond)
         Rudolf Marek <r.marek at sh.cvut.cz>
 
 Description
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 7a58b07..833faa2 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -2,7 +2,7 @@
     w83627ehf - Driver for the hardware monitoring functionality of
                 the Winbond W83627EHF Super-I/O chip
     Copyright (C) 2005  Jean Delvare <khali at linux-fr.org>
-    Copyright (C) 2006  Yuan Mu <Ymu at Winbond.com.tw>,
+    Copyright (C) 2006  Yuan Mu (Winbond),
                         Rudolf Marek <r.marek at sh.cvut.cz>
                         David Hubbard <david.c.hubbard at gmail.com>
 
-- 
1.4.2.1


