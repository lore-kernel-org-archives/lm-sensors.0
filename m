From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:26:26 +0000
Subject: [lm-sensors] [PATCH 02/11] hwmon: (adt7475) Add missing static
Message-Id: <20091202162626.3200707e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

adt7475_attr_group is used internally only and can thus be marked
static.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 drivers/hwmon/adt7475.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-11-29 17:43:06.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-11-29 17:43:37.000000000 +0100
@@ -1008,7 +1008,7 @@ static struct attribute *adt7475_attrs[]
 	NULL,
 };
 
-struct attribute_group adt7475_attr_group = { .attrs = adt7475_attrs };
+static struct attribute_group adt7475_attr_group = { .attrs = adt7475_attrs };
 
 static int adt7475_detect(struct i2c_client *client, int kind,
 			  struct i2c_board_info *info)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
