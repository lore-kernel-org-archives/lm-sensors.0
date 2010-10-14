From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 07:57:53 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm85) Fix ADT7468 frequency table
Message-Id: <20101014095753.712ac143@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ADT7468 uses the same frequency table as the ADT7463.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@kernel.org
Cc: Darrick J. Wong <djwong@us.ibm.com>
---
 drivers/hwmon/lm85.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.36-rc7.orig/drivers/hwmon/lm85.c	2010-10-14 09:25:50.000000000 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/lm85.c	2010-10-14 09:30:12.000000000 +0200
@@ -1259,6 +1259,7 @@ static int lm85_probe(struct i2c_client
 	switch (data->type) {
 	case adm1027:
 	case adt7463:
+	case adt7468:
 	case emc6d100:
 	case emc6d102:
 		data->freq_map = adm1027_freq_map;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
