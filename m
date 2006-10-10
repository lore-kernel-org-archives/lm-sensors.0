From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 10 Oct 2006 20:54:25 +0000
Subject: [lm-sensors] patch hwmon-update-Grant-Coady-email-address.patch
Message-Id: <20061010205417.8EF198FD5EB@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 2/6] adm9240: Update Grant Coady's email address

to my gregkh-2.6 tree.  Its filename is

     hwmon-update-Grant-Coady-email-address.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Oct  8 12:57:48 2006
Date: Sun, 8 Oct 2006 21:57:41 +0200
From: Grant Coady <gcoady.lk at gmail.com>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Grant Coady <gcoady.lk at gmail.com>
Subject: [PATCH 2/6] adm9240: Update Grant Coady's email address
Message-Id: <20061008215741.e226180d.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-update-Grant-Coady-email-address.patch

From: Grant Coady <gcoady.lk at gmail.com>

Replace a bouncing email that I cannot recover from Mr Google.

Signed-off-by: Grant Coady <gcoady.lk at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 Documentation/hwmon/adm9240 |    2 +-
 drivers/hwmon/adm9240.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/Documentation/hwmon/adm9240
+++ gregkh-2.6/Documentation/hwmon/adm9240
@@ -24,7 +24,7 @@ Authors:
     Frodo Looijaard <frodol at dds.nl>,
     Philip Edelbrock <phil at netroedge.com>,
     Michiel Rook <michiel at grendelproject.nl>,
-    Grant Coady <gcoady at gmail.com> with guidance
+    Grant Coady <gcoady.lk at gmail.com> with guidance
         from Jean Delvare <khali at linux-fr.org>
 
 Interface
--- gregkh-2.6.orig/drivers/hwmon/adm9240.c
+++ gregkh-2.6/drivers/hwmon/adm9240.c
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
 


Patches currently in gregkh-2.6 which might be from gcoady.lk at gmail.com are

i2c/hwmon-update-Grant-Coady-email-address.patch

