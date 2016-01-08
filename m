From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 08 Jan 2016 11:03:21 +0000
Subject: [lm-sensors] [patch] hwmon: (emc2103) Fix typo in MODULE_PARM_DESC
Message-Id: <20160108110321.GK32195@mwanda>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Glendinning <steve.glendinning@shawell.net>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

"apd" was intended here instead of "init".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index 952fe69..24e395c 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -58,7 +58,7 @@ static const u8 REG_TEMP_MAX[4] = { 0x34, 0x30, 0x31, 0x32 };
  */
 static int apd = -1;
 module_param(apd, bint, 0);
-MODULE_PARM_DESC(init, "Set to zero to disable anti-parallel diode mode");
+MODULE_PARM_DESC(apd, "Set to zero to disable anti-parallel diode mode");
 
 struct temperature {
 	s8	degrees;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
