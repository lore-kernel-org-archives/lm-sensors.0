From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Jul 2011 17:35:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Fix label group removal
Message-Id: <20110711193528.25fed27f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A copy-and-paste error caused it87_attributes_vid to be referenced
where it87_attributes_label should be. Thankfully the group is only
used for attribute removal, not attribute creation, so the effects of
this bug are limited, but let's fix it still.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@kernel.org
---
 drivers/hwmon/it87.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.0-rc6.orig/drivers/hwmon/it87.c	2011-05-30 20:45:09.000000000 +0200
+++ linux-3.0-rc6/drivers/hwmon/it87.c	2011-07-11 18:34:43.000000000 +0200
@@ -1538,7 +1538,7 @@ static struct attribute *it87_attributes
 };
 
 static const struct attribute_group it87_group_label = {
-	.attrs = it87_attributes_vid,
+	.attrs = it87_attributes_label,
 };
 
 /* SuperIO detection - will change isa_address if a chip is found */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
