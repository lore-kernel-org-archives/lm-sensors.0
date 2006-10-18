From: greg@kroah.com (Greg KH)
Date: Wed, 18 Oct 2006 20:09:33 +0000
Subject: [lm-sensors] [PATCH 2/8] adm9240: Update Grant Coady's email address
Message-Id: <11612021821403-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Grant Coady <gcoady.lk at gmail.com>

Replace a bouncing email that I cannot recover from Mr Google.

Signed-off-by: Grant Coady <gcoady.lk at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/hwmon/adm9240 |    2 +-
 drivers/hwmon/adm9240.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/adm9240 b/Documentation/hwmon/adm9240
index 35f618f..2c6f1fe 100644
--- a/Documentation/hwmon/adm9240
+++ b/Documentation/hwmon/adm9240
@@ -24,7 +24,7 @@ Authors:
     Frodo Looijaard <frodol at dds.nl>,
     Philip Edelbrock <phil at netroedge.com>,
     Michiel Rook <michiel at grendelproject.nl>,
-    Grant Coady <gcoady at gmail.com> with guidance
+    Grant Coady <gcoady.lk at gmail.com> with guidance
         from Jean Delvare <khali at linux-fr.org>
 
 Interface
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 377961c..aad594a 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -5,7 +5,7 @@
  * Copyright (C) 1999	Frodo Looijaard <frodol at dds.nl>
  *			Philip Edelbrock <phil at netroedge.com>
  * Copyright (C) 2003	Michiel Rook <michiel at grendelproject.nl>
- * Copyright (C) 2005	Grant Coady <gcoady at gmail.com> with valuable
+ * Copyright (C) 2005	Grant Coady <gcoady.lk at gmail.com> with valuable
  * 				guidance from Jean Delvare
  *
  * Driver supports	Analog Devices		ADM9240
@@ -774,7 +774,7 @@ static void __exit sensors_adm9240_exit(
 }
 
 MODULE_AUTHOR("Michiel Rook <michiel at grendelproject.nl>, "
-		"Grant Coady <gcoady at gmail.com> and others");
+		"Grant Coady <gcoady.lk at gmail.com> and others");
 MODULE_DESCRIPTION("ADM9240/DS1780/LM81 driver");
 MODULE_LICENSE("GPL");
 
-- 
1.4.2.4


