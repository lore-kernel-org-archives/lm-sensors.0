From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 14 Aug 2013 09:45:26 +0000
Subject: [lm-sensors] [patch] hwmon: (adt7462) ADT7462_REG_VOLT_MAX() should return 0
Message-Id: <20130814094526.GE521@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

The callers never check for negative but they sometimes check for zero
returns:

	int reg = ADT7462_REG_VOLT_MAX(data, i);
        data->volt_max[i] 		(reg ? i2c_smbus_read_byte_data(client, reg) : 0);

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker stuff.  I don't have this hardware.

diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 69481d3..3e6aba1 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -333,7 +333,7 @@ static int ADT7462_REG_VOLT_MAX(struct adt7462_data *data, int which)
 			return 0x4C;
 		break;
 	}
-	return -ENODEV;
+	return 0;
 }
 
 static int ADT7462_REG_VOLT_MIN(struct adt7462_data *data, int which)
@@ -392,7 +392,7 @@ static int ADT7462_REG_VOLT_MIN(struct adt7462_data *data, int which)
 			return 0x77;
 		break;
 	}
-	return -ENODEV;
+	return 0;
 }
 
 static int ADT7462_REG_VOLT(struct adt7462_data *data, int which)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
