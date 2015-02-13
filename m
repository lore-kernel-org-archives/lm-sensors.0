From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Feb 2015 20:44:42 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (nct6775) Restore hardware monitoring logical device status on resum
Message-Id: <1423860283-3938-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After a suspend/resume cycle it is not guaranteed that the hardware monitoring
device is still enabled. Ensure that this is the case after resume.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index db6a68e..0445a52 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -885,6 +885,7 @@ struct nct6775_data {
 	u8 vbat;
 	u8 fandiv1;
 	u8 fandiv2;
+	u8 sio_reg_enable;
 };
 
 struct nct6775_sio_data {
@@ -3177,6 +3178,10 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 	int sioreg = data->sioreg;
 	int regval;
 
+	/* Store SIO_REG_ENABLE for use during resume */
+	superio_select(sioreg, NCT6775_LD_HWM);
+	data->sio_reg_enable = superio_inb(sioreg, SIO_REG_ENABLE);
+
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 	if (data->kind = nct6775) {
 		regval = superio_inb(sioreg, 0x2c);
@@ -3195,20 +3200,17 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 	} else if (data->kind = nct6776) {
 		bool gpok = superio_inb(sioreg, 0x27) & 0x80;
 
-		superio_select(sioreg, NCT6775_LD_HWM);
-		regval = superio_inb(sioreg, SIO_REG_ENABLE);
-
-		if (regval & 0x80)
+		if (data->sio_reg_enable & 0x80)
 			fan3pin = gpok;
 		else
 			fan3pin = !(superio_inb(sioreg, 0x24) & 0x40);
 
-		if (regval & 0x40)
+		if (data->sio_reg_enable & 0x40)
 			fan4pin = gpok;
 		else
 			fan4pin = superio_inb(sioreg, 0x1C) & 0x01;
 
-		if (regval & 0x20)
+		if (data->sio_reg_enable & 0x20)
 			fan5pin = gpok;
 		else
 			fan5pin = superio_inb(sioreg, 0x1C) & 0x02;
@@ -4006,19 +4008,26 @@ static int __maybe_unused nct6775_suspend(struct device *dev)
 static int __maybe_unused nct6775_resume(struct device *dev)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
+	int sioreg = data->sioreg;
 	int i, j, err = 0;
+	u8 reg;
 
 	mutex_lock(&data->update_lock);
 	data->bank = 0xff;		/* Force initial bank selection */
 
-	if (data->kind = nct6791 || data->kind = nct6792) {
-		err = superio_enter(data->sioreg);
-		if (err)
-			goto abort;
+	err = superio_enter(sioreg);
+	if (err)
+		goto abort;
 
-		nct6791_enable_io_mapping(data->sioreg);
-		superio_exit(data->sioreg);
-	}
+	superio_select(sioreg, NCT6775_LD_HWM);
+	reg = superio_inb(sioreg, SIO_REG_ENABLE);
+	if (reg != data->sio_reg_enable)
+		superio_outb(sioreg, SIO_REG_ENABLE, data->sio_reg_enable);
+
+	if (data->kind = nct6791 || data->kind = nct6792)
+		nct6791_enable_io_mapping(sioreg);
+
+	superio_exit(sioreg);
 
 	/* Restore limits */
 	for (i = 0; i < data->in_num; i++) {
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
