From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:50 +0000
Subject: [lm-sensors] [PATCH 56/82] hwmon: (sch5636) Fix multi-line comments
Message-Id: <1327017376-20466-57-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sch5636.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 9d5236f..3226c6f 100644
--- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -1,4 +1,5 @@
-/***************************************************************************
+/*
+ ***************************************************************************
  *   Copyright (C) 2011 Hans de Goede <hdegoede@redhat.com>                *
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
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
