From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 10 Aug 2012 09:24:13 +0000
Subject: [lm-sensors] [patch] hwmon: (sch56xx-common) signedness bug in sch56xx_init()
Message-Id: <20120810092412.GB26875@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

"address" is used to store an unsigned short on success but a negative
error code on failure.  It needs to be an int for the error handling to
work.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is for linux-next.  The bug was introduced in 1645e4fc "hwmon:
(sch56xx-common) Fix build warnings"

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 69abbf7..c93061f5 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -594,7 +594,7 @@ exit_device_put:
 
 static int __init sch56xx_init(void)
 {
-	unsigned short address;
+	int address;
 	const char *name = NULL;
 
 	address = sch56xx_find(0x4e, &name);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
