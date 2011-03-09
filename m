From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:07 +0000
Subject: [lm-sensors] [PATCH 01/10] hwmon/f71882fg: Fix temp1 sensor type
Message-Id: <1299700636-9699-2-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The code for determining a sensort type for temp1 was based on me misreading
the datasheet, the tested registers do not determine what kind of sensor
is actually reported as temp1. Instead the enable / disable certain additional
digital sensor readouts throug PECI / AMDSI, etc. Independent of these settings
temp1 is still reading an external BJT or thermistor as configured by the
Temperature Sensor Type Register (0x6b).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |   35 +++--------------------------------
 1 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 3f49dd3..1278e4a 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -1,6 +1,6 @@
 /***************************************************************************
  *   Copyright (C) 2006 by Hans Edgington <hans@edgington.nl>              *
- *   Copyright (C) 2007-2009 Hans de Goede <hdegoede@redhat.com>           *
+ *   Copyright (C) 2007-2011 Hans de Goede <hdegoede@redhat.com>           *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
  *   it under the terms of the GNU General Public License as published by  *
@@ -57,8 +57,6 @@
 #define ADDR_REG_OFFSET		5
 #define DATA_REG_OFFSET		6
 
-#define F71882FG_REG_PECI		0x0A
-
 #define F71882FG_REG_IN_STATUS		0x12 /* f71882fg only */
 #define F71882FG_REG_IN_BEEP		0x13 /* f71882fg only */
 #define F71882FG_REG_IN(nr)		(0x20  + (nr))
@@ -943,7 +941,7 @@ static u16 f71882fg_read_temp(struct f71882fg_data *data, int nr)
 static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr, reg = 0, reg2;
+	int nr, reg;
 	int nr_fans = (data->type = f71882fg) ? 4 : 3;
 	int nr_ins = (data->type = f71858fg || data->type = f8000) ? 3 : 9;
 
@@ -980,38 +978,11 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 						F71882FG_REG_FAN_BEEP);
 			data->temp_beep = f71882fg_read8(data,
 						F71882FG_REG_TEMP_BEEP);
-			/* Have to hardcode type, because temp1 is special */
 			reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
+			data->temp_type[1] = (reg & 0x02) ? 2 : 4;
 			data->temp_type[2] = (reg & 0x04) ? 2 : 4;
 			data->temp_type[3] = (reg & 0x08) ? 2 : 4;
 		}
-		/* Determine temp index 1 sensor type */
-		if (data->type = f71889fg) {
-			reg2 = f71882fg_read8(data, F71882FG_REG_START);
-			switch ((reg2 & 0x60) >> 5) {
-			case 0x00: /* BJT / Thermistor */
-				data->temp_type[1] = (reg & 0x02) ? 2 : 4;
-				break;
-			case 0x01: /* AMDSI */
-				data->temp_type[1] = 5;
-				break;
-			case 0x02: /* PECI */
-			case 0x03: /* Ibex Peak ?? Report as PECI for now */
-				data->temp_type[1] = 6;
-				break;
-			}
-		} else {
-			reg2 = f71882fg_read8(data, F71882FG_REG_PECI);
-			if ((reg2 & 0x03) = 0x01)
-				data->temp_type[1] = 6; /* PECI */
-			else if ((reg2 & 0x03) = 0x02)
-				data->temp_type[1] = 5; /* AMDSI */
-			else if (data->type = f71862fg ||
-				 data->type = f71882fg)
-				data->temp_type[1] = (reg & 0x02) ? 2 : 4;
-			else /* f71858fg and f8000 only support BJT */
-				data->temp_type[1] = 2;
-		}
 
 		data->pwm_enable = f71882fg_read8(data,
 						  F71882FG_REG_PWM_ENABLE);
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
