From: "Andrew Paprocki" <andrew@ishiboo.com>
Date: Mon, 11 Feb 2008 06:32:59 +0000
Subject: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading in
Message-Id: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This splits the it8712 chip type into two chip types to distinguish the
changes made in rev 8 of the chip. A new type it8712old represents all
revs prior to rev 8. The it8712 chip type now represents rev 8 and
greater. For clarity, the it87 chip type is now named it8705.

The it8712 chip type now enables 16-bit fan tachometer reading to get
proper readings. The register used in the it8712old chip type no longer
has the same meaning in rev 8 of the chip.

Also, a new module param array enable_fans is added. This was needed to
get fan2 to show up on an it8712 rev 8 chip which was not enabled at
boot time by the BIOS. The module param is checked and if a fan index
value is 1, the fan is forced on even if it is not configured that way
from the BIOS.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
---
  drivers/hwmon/it87.c |   84
+++++++++++++++++++++++++++++++++++++-------------
  1 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index ad6c8a3..3c23726 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -50,7 +50,7 @@

  #define DRVNAME "it87"

-enum chips { it87, it8712, it8716, it8718 };
+enum chips { it8705, it8712old, it8712, it8716, it8718 };

  static struct platform_device *pdev;

@@ -121,6 +121,9 @@ static int update_vbat;
  /* Not all BIOSes properly configure the PWM registers */
  static int fix_pwm_polarity;

+/* Not all BIOSes properly enable all available fans */
+static int enable_fans[5];
+
  /* Many IT87 constants specified below */

  /* Length of ISA address segment */
@@ -145,11 +148,11 @@ static int fix_pwm_polarity;
  #define IT87_REG_ALARM3        0x03

  /* The IT8718F has the VID value in a different register, in Super-I/O
-   configuration space. */
+ * configuration space. */
  #define IT87_REG_VID           0x0a
-/* Warning: register 0x0b is used for something completely different in
-   new chips/revisions. I suspect only 16-bit tachometer mode will work
-   for these. */
+/* The IT8705F and IT8712F earlier than revision 0x08 use register 0x0b
+ * for fan divisors. Later IT8712F revisions must use 16-bit tachometer
+ * mode. */
  #define IT87_REG_FAN_DIV       0x0b
  #define IT87_REG_FAN_16BIT     0x0c

@@ -904,16 +907,21 @@ static int __init it87_find(unsigned short *address,
  {
  	int err = -ENODEV;
  	u16 chip_type;
+        u8 revision;

  	superio_enter();
  	chip_type = superio_inw(DEVID);
+        revision = superio_inb(DEVREV);

  	switch (chip_type) {
  	case IT8705F_DEVID:
-		sio_data->type = it87;
+		sio_data->type = it8705;
  		break;
  	case IT8712F_DEVID:
-		sio_data->type = it8712;
+                if (revision < 0x08)
+                        sio_data->type = it8712old;
+                else
+                        sio_data->type = it8712;
  		break;
  	case IT8716F_DEVID:
  	case IT8726F_DEVID:
@@ -975,7 +983,8 @@ static int __devinit it87_probe(struct
platform_device *pdev)
  	int err = 0;
  	int enable_pwm_interface;
  	static const char *names[] = {
-		"it87",
+		"it8705",
+		"it8712",
  		"it8712",
  		"it8716",
  		"it8718",
@@ -1021,7 +1030,7 @@ static int __devinit it87_probe(struct
platform_device *pdev)
  		goto ERROR2;

  	/* Do not create fan files for disabled fans */
-	if (data->type = it8716 || data->type = it8718) {
+        if (data->type != it8705 && data->type != it8712old) {
  		/* 16-bit tachometers */
  		if (data->has_fan & (1 << 0)) {
  			if ((err = device_create_file(dev,
@@ -1111,8 +1120,7 @@ static int __devinit it87_probe(struct
platform_device *pdev)
  			goto ERROR4;
  	}

-	if (data->type = it8712 || data->type = it8716
-	 || data->type = it8718) {
+	if (data->type != it8705) {
  		data->vrm = vid_which_vrm();
  		/* VID reading from Super-I/O config space if available */
  		data->vid = sio_data->vid_value;
@@ -1232,6 +1240,7 @@ static void __devinit it87_init_device(struct
platform_device *pdev)
  {
  	struct it87_data *data = platform_get_drvdata(pdev);
  	int tmp, i;
+        u8 force_fan_main_ctrl;

  	/* initialize to sane defaults:
  	 * - if the chip is in manual pwm mode, this will be overwritten with
@@ -1283,21 +1292,43 @@ static void __devinit it87_init_device(struct
platform_device *pdev)
  		data->fan_main_ctrl |= 0x70;
  		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
  	}
+
+        /* Force on any of the first three fans */
+        force_fan_main_ctrl = data->fan_main_ctrl;
+        if (enable_fans[0])
+                force_fan_main_ctrl |= (1 << 4);
+        if (enable_fans[1])
+                force_fan_main_ctrl |= (1 << 5);
+        if (enable_fans[2])
+                force_fan_main_ctrl |= (1 << 6);
+        if (force_fan_main_ctrl != data->fan_main_ctrl) {
+                data->fan_main_ctrl = force_fan_main_ctrl;
+                it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
+                                 data->fan_main_ctrl);
+        }
+
  	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;

  	/* Set tachometers to 16-bit mode if needed */
-	if (data->type = it8716 || data->type = it8718) {
-		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
+	if (data->type = it8712 || data->type = it8716
+         || data->type = it8718) {
+                int new_tmp = tmp = it87_read_value(data,
IT87_REG_FAN_16BIT);
  		if (~tmp & 0x07 & data->has_fan) {
  			dev_dbg(&pdev->dev,
-				"Setting fan1-3 to 16-bit mode\n");
-			it87_write_value(data, IT87_REG_FAN_16BIT,
-					 tmp | 0x07);
+				"Setting all fans to 16-bit mode\n");
+			it87_write_value(data, IT87_REG_FAN_16BIT, tmp | 0x07);
  		}
  		if (tmp & (1 << 4))
  			data->has_fan |= (1 << 3);	/* fan4 enabled */
+                else if (enable_fans[3])
+                        new_tmp |= (1 << 3);            /* fan4 force
enabled */
  		if (tmp & (1 << 5))
  			data->has_fan |= (1 << 4);	/* fan5 enabled */
+                else if (enable_fans[4])
+                        new_tmp |= (1 << 4);            /* fan5 force
enabled */
+
+                if (new_tmp != tmp)
+                        it87_write_value(data, IT87_REG_FAN_16BIT,
new_tmp);
  	}

  	/* Set current fan mode registers and the default settings for the
@@ -1316,7 +1347,9 @@ static void __devinit it87_init_device(struct
platform_device *pdev)
  				data->manual_pwm_ctl[i] = PWM_FROM_REG(tmp);
  			}
  		}
- 	}
+	}
+
+        /* FIXME: perform the above logic for fan4 and fan5 if necessary */

  	/* Start monitoring */
  	it87_write_value(data, IT87_REG_CONFIG,
@@ -1362,7 +1395,8 @@ static struct it87_data *it87_update_device(struct
device *dev)
  			data->fan[i] = it87_read_value(data,
  				       IT87_REG_FAN[i]);
  			/* Add high byte if in 16-bit mode */
-			if (data->type = it8716 || data->type = it8718) {
+			if (data->type = it8712 || data->type = it8716
+                         || data->type = it8718) {
  				data->fan[i] |= it87_read_value(data,
  						IT87_REG_FANX[i]) << 8;
  				data->fan_min[i] |= it87_read_value(data,
@@ -1378,9 +1412,11 @@ static struct it87_data
*it87_update_device(struct device *dev)
  			    it87_read_value(data, IT87_REG_TEMP_LOW(i));
  		}

-		/* Newer chips don't have clock dividers */
-		if ((data->has_fan & 0x07) && data->type != it8716
-		 && data->type != it8718) {
+                /* The 8705 uses fan divisors. The 8712 had fan divisors
+                 * prior to revision 0x08.
+                 */
+		if ((data->has_fan & 0x07) &&
+                    (data->type = it8705 || data->type = it8712old)) {
  			i = it87_read_value(data, IT87_REG_FAN_DIV);
  			data->fan_div[0] = i & 0x07;
  			data->fan_div[1] = (i >> 3) & 0x07;
@@ -1396,7 +1432,9 @@ static struct it87_data *it87_update_device(struct
device *dev)
  		data->fan_ctl = it87_read_value(data, IT87_REG_FAN_CTL);

  		data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
-		/* The 8705 does not have VID capability */
+                /* The 8705 does not have VID capability.
+                 * The 8718 does not use IT87_REG_VID for the same purpose.
+                 */
  		if (data->type = it8712 || data->type = it8716) {
  			data->vid = it87_read_value(data, IT87_REG_VID);
  			/* The older IT8712F revisions had only 5 VID pins,
@@ -1495,6 +1533,8 @@ module_param(update_vbat, bool, 0);
  MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup
value");
  module_param(fix_pwm_polarity, bool, 0);
  MODULE_PARM_DESC(fix_pwm_polarity, "Force PWM polarity to active high
(DANGEROUS)");
+module_param_array(enable_fans, bool, 0, 0444);
+MODULE_PARM_DESC(enable_fans, "Force enable fans (up to 5 fans when
supported)");
  MODULE_LICENSE("GPL");

  module_init(sm_it87_init);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
