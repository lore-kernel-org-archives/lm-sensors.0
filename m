From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 19:57:41 +0000
Subject: [lm-sensors] [PATCH 2/6] adm9240: Update Grant Coady's email address
Message-Id: <20061008215741.e226180d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Grant Coady <gcoady.lk at gmail.com>
Content-Disposition: inline; filename=hwmon-update-Grant-Coady-email-address.patch

Replace a bouncing email that I cannot recover from Mr Google.

Signed-off-by: Grant Coady <gcoady.lk at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/adm9240 |    2 +-
 drivers/hwmon/adm9240.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc1.orig/Documentation/hwmon/adm9240	2006-10-08 12:48:09.000000000 +0200
+++ linux-2.6.19-rc1/Documentation/hwmon/adm9240	2006-10-08 14:51:50.000000000 +0200
@@ -24,7 +24,7 @@
     Frodo Looijaard <frodol at dds.nl>,
     Philip Edelbrock <phil at netroedge.com>,
     Michiel Rook <michiel at grendelproject.nl>,
-    Grant Coady <gcoady at gmail.com> with guidance
+    Grant Coady <gcoady.lk at gmail.com> with guidance
         from Jean Delvare <khali at linux-fr.org>
 
 Interface
--- linux-2.6.19-rc1.orig/drivers/hwmon/adm9240.c	2006-10-08 12:48:09.000000000 +0200
+++ linux-2.6.19-rc1/drivers/hwmon/adm9240.c	2006-10-08 14:51:50.000000000 +0200
@@ -5,7 +5,7 @@
  * Copyright (C) 1999	Frodo Looijaard <frodol at dds.nl>
  *			Philip Edelbrock <phil at netroedge.com>
  * Copyright (C) 2003	Michiel Rook <michiel at grendelproject.nl>
- * Copyright (C) 2005	Grant Coady <gcoady at gmail.com> with valuable
+ * Copyright (C) 2005	Grant Coady <gcoady.lk at gmail.com> with valuable
  * 				guidance from Jean Delvare
  *
  * Driver supports	Analog Devices		ADM9240
@@ -774,7 +774,7 @@
 }
 
 MODULE_AUTHOR("Michiel Rook <michiel at grendelproject.nl>, "
-		"Grant Coady <gcoady at gmail.com> and others");
+		"Grant Coady <gcoady.lk at gmail.com> and others");
 MODULE_DESCRIPTION("ADM9240/DS1780/LM81 driver");
 MODULE_LICENSE("GPL");
 

-- 
Jean Delvare

