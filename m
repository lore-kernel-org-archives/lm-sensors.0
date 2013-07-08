From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Jul 2013 20:49:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Avoid using device platform data outside probe function
Message-Id: <1373316547-9605-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Plan going forward is to attach all device attributes to the hwmon device and no
longer to the platform device. With that change, accessing platform data outside
the probe function will be more difficult. To avoid the problem, change code
to no longer rely on it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Also reduces code size by about 100 bytes.

 drivers/hwmon/nct6775.c |   51 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 3a9bb66..f0941d7 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -720,6 +720,7 @@ static inline u8 in_to_reg(u32 val, u8 nr)
 
 struct nct6775_data {
 	int addr;	/* IO base of hw monitor block */
+	int sioreg;	/* SIO register address */
 	enum kinds kind;
 	const char *name;
 
@@ -3008,7 +3009,6 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	       const char *buf, size_t count)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	struct nct6775_sio_data *sio_data = dev->platform_data;
 	int nr = to_sensor_dev_attr(attr)->index - INTRUSION_ALARM_BASE;
 	unsigned long val;
 	u8 reg;
@@ -3024,19 +3024,19 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	 * The CR registers are the same for all chips, and not all chips
 	 * support clearing the caseopen status through "regular" registers.
 	 */
-	ret = superio_enter(sio_data->sioreg);
+	ret = superio_enter(data->sioreg);
 	if (ret) {
 		count = ret;
 		goto error;
 	}
 
-	superio_select(sio_data->sioreg, NCT6775_LD_ACPI);
-	reg = superio_inb(sio_data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
+	superio_select(data->sioreg, NCT6775_LD_ACPI);
+	reg = superio_inb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
 	reg |= NCT6775_CR_CASEOPEN_CLR_MASK[nr];
-	superio_outb(sio_data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	superio_outb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
 	reg &= ~NCT6775_CR_CASEOPEN_CLR_MASK[nr];
-	superio_outb(sio_data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
-	superio_exit(sio_data->sioreg);
+	superio_outb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	superio_exit(data->sioreg);
 
 	data->valid = false;	/* Force cache refresh */
 error:
@@ -3163,22 +3163,22 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 }
 
 static void
-nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
-			 struct nct6775_data *data)
+nct6775_check_fan_inputs(struct nct6775_data *data)
 {
-	int regval;
 	bool fan3pin, fan4pin, fan4min, fan5pin, fan6pin;
 	bool pwm3pin, pwm4pin, pwm5pin, pwm6pin;
+	int sioreg = data->sioreg;
+	int regval;
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 	if (data->kind = nct6775) {
-		regval = superio_inb(sio_data->sioreg, 0x2c);
+		regval = superio_inb(sioreg, 0x2c);
 
 		fan3pin = regval & (1 << 6);
 		pwm3pin = regval & (1 << 7);
 
 		/* On NCT6775, fan4 shares pins with the fdc interface */
-		fan4pin = !(superio_inb(sio_data->sioreg, 0x2A) & 0x80);
+		fan4pin = !(superio_inb(sioreg, 0x2A) & 0x80);
 		fan4min = false;
 		fan5pin = false;
 		fan6pin = false;
@@ -3186,25 +3186,25 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 		pwm5pin = false;
 		pwm6pin = false;
 	} else if (data->kind = nct6776) {
-		bool gpok = superio_inb(sio_data->sioreg, 0x27) & 0x80;
+		bool gpok = superio_inb(sioreg, 0x27) & 0x80;
 
-		superio_select(sio_data->sioreg, NCT6775_LD_HWM);
-		regval = superio_inb(sio_data->sioreg, SIO_REG_ENABLE);
+		superio_select(sioreg, NCT6775_LD_HWM);
+		regval = superio_inb(sioreg, SIO_REG_ENABLE);
 
 		if (regval & 0x80)
 			fan3pin = gpok;
 		else
-			fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
+			fan3pin = !(superio_inb(sioreg, 0x24) & 0x40);
 
 		if (regval & 0x40)
 			fan4pin = gpok;
 		else
-			fan4pin = superio_inb(sio_data->sioreg, 0x1C) & 0x01;
+			fan4pin = superio_inb(sioreg, 0x1C) & 0x01;
 
 		if (regval & 0x20)
 			fan5pin = gpok;
 		else
-			fan5pin = superio_inb(sio_data->sioreg, 0x1C) & 0x02;
+			fan5pin = superio_inb(sioreg, 0x1C) & 0x02;
 
 		fan4min = fan4pin;
 		fan6pin = false;
@@ -3213,7 +3213,7 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 		pwm5pin = false;
 		pwm6pin = false;
 	} else if (data->kind = nct6106) {
-		regval = superio_inb(sio_data->sioreg, 0x24);
+		regval = superio_inb(sioreg, 0x24);
 		fan3pin = !(regval & 0x80);
 		pwm3pin = regval & 0x08;
 
@@ -3225,7 +3225,7 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 		pwm5pin = false;
 		pwm6pin = false;
 	} else {	/* NCT6779D or NCT6791D */
-		regval = superio_inb(sio_data->sioreg, 0x1c);
+		regval = superio_inb(sioreg, 0x1c);
 
 		fan3pin = !(regval & (1 << 5));
 		fan4pin = !(regval & (1 << 6));
@@ -3238,7 +3238,7 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 		fan4min = fan4pin;
 
 		if (data->kind = nct6791) {
-			regval = superio_inb(sio_data->sioreg, 0x2d);
+			regval = superio_inb(sioreg, 0x2d);
 			fan6pin = (regval & (1 << 1));
 			pwm6pin = (regval & (1 << 0));
 		} else {	/* NCT6779D */
@@ -3308,6 +3308,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->kind = sio_data->kind;
+	data->sioreg = sio_data->sioreg;
 	data->addr = res->start;
 	mutex_init(&data->update_lock);
 	data->name = nct6775_device_names[data->kind];
@@ -3859,7 +3860,7 @@ static int nct6775_probe(struct platform_device *pdev)
 			 data->name);
 	}
 
-	nct6775_check_fan_inputs(sio_data, data);
+	nct6775_check_fan_inputs(data);
 
 	superio_exit(sio_data->sioreg);
 
@@ -3930,11 +3931,10 @@ static int nct6775_remove(struct platform_device *pdev)
 static int nct6775_suspend(struct device *dev)
 {
 	struct nct6775_data *data = nct6775_update_device(dev);
-	struct nct6775_sio_data *sio_data = dev->platform_data;
 
 	mutex_lock(&data->update_lock);
 	data->vbat = nct6775_read_value(data, data->REG_VBAT);
-	if (sio_data->kind = nct6775) {
+	if (data->kind = nct6775) {
 		data->fandiv1 = nct6775_read_value(data, NCT6775_REG_FANDIV1);
 		data->fandiv2 = nct6775_read_value(data, NCT6775_REG_FANDIV2);
 	}
@@ -3946,7 +3946,6 @@ static int nct6775_suspend(struct device *dev)
 static int nct6775_resume(struct device *dev)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	struct nct6775_sio_data *sio_data = dev->platform_data;
 	int i, j;
 
 	mutex_lock(&data->update_lock);
@@ -3983,7 +3982,7 @@ static int nct6775_resume(struct device *dev)
 
 	/* Restore other settings */
 	nct6775_write_value(data, data->REG_VBAT, data->vbat);
-	if (sio_data->kind = nct6775) {
+	if (data->kind = nct6775) {
 		nct6775_write_value(data, NCT6775_REG_FANDIV1, data->fandiv1);
 		nct6775_write_value(data, NCT6775_REG_FANDIV2, data->fandiv2);
 	}
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
