From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:49 +0000
Subject: [lm-sensors] [PATCH 55/82] hwmon: (sch5627) Fix multi-line comments
Message-Id: <1327017376-20466-56-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sch5627.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 79b6dab..cd80fbc 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -1,4 +1,5 @@
-/***************************************************************************
+/*
+ ***************************************************************************
  *   Copyright (C) 2010-2011 Hans de Goede <hdegoede@redhat.com>           *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
@@ -15,7 +16,8 @@
  *   along with this program; if not, write to the                         *
  *   Free Software Foundation, Inc.,                                       *
  *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
- ***************************************************************************/
+ ***************************************************************************
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -544,8 +546,10 @@ static int __devinit sch5627_probe(struct platform_device *pdev)
 		err = -ENODEV;
 		goto error;
 	}
-	/* Trigger a Vbat voltage measurement, so that we get a valid reading
-	   the first time we read Vbat */
+	/*
+	 * Trigger a Vbat voltage measurement, so that we get a valid reading
+	 * the first time we read Vbat
+	 */
 	sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL,
 				  data->control | 0x10);
 	data->last_battery = jiffies;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
