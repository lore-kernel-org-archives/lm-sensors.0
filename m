From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH 2.6] I2C: Do not register useless smsc47m1
Message-Id: <20041113161124.1a546464.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

While verifying my stack of patches against what you sent to Linus last
week, I noticed this one. Looks like I simply forgot to send it to you,
as I cannot find any trace of it in the lm_sensors mailing-list
archives.

The patch prevents an smsc47m1 device from being registered when no
monitoring function is actually active within the chip. See this ticket
for background:
  http://secure.netroedge.com/~lm78/readticket.cgi?ticket01
This is certainly better to explicitely fail in this case than leave the
user with an empty sysfs directory (except for alarms), which tends to
make him/her think of a driver bug, which it isn't (what it really is is
a BIOS brokenness).

This isn't fixing any critical bug and can be delayed until after 2.6.10
is released.

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc1/drivers/i2c/chips/smsc47m1.c.orig	2004-10-26 20:48:19.000000000 +0200
+++ linux-2.6.10-rc1/drivers/i2c/chips/smsc47m1.c	2004-10-27 19:23:31.000000000 +0200
@@ -394,6 +394,7 @@
 	struct i2c_client *new_client;
 	struct smsc47m1_data *data;
 	int err = 0;
+	int fan1, fan2, pwm1, pwm2;
 
 	if (!i2c_is_isa_adapter(adapter)) {
 		return 0;
@@ -423,6 +424,22 @@
 	new_client->id = smsc47m1_id++;
 	init_MUTEX(&data->update_lock);
 
+	/* If no function is properly configured, there's no point in
+	   actually registering the chip. */
+	fan1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(0)) & 0x05)
+	       = 0x05;
+	fan2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(1)) & 0x05)
+	       = 0x05;
+	pwm1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(0)) & 0x05)
+	       = 0x04;
+	pwm2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
+	       = 0x04;
+	if (!(fan1 || fan2 || pwm1 || pwm2)) {
+		dev_warn(&new_client->dev, "Device is not configured, will not use\n");
+		err = -ENODEV;
+		goto error_free;
+	}
+
 	if ((err = i2c_attach_client(new_client)))
 		goto error_free;
 
@@ -434,8 +451,7 @@
 	   function. */
 	smsc47m1_update_device(&new_client->dev, 1);
 
-	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(0)) & 0x05)
-	    = 0x05) {
+	if (fan1) {
 		device_create_file(&new_client->dev, &dev_attr_fan1_input);
 		device_create_file(&new_client->dev, &dev_attr_fan1_min);
 		device_create_file(&new_client->dev, &dev_attr_fan1_div);
@@ -443,8 +459,7 @@
 		dev_dbg(&new_client->dev, "Fan 1 not enabled by hardware, "
 			"skipping\n");
 
-	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(1)) & 0x05)
-	    = 0x05) {
+	if (fan2) {
 		device_create_file(&new_client->dev, &dev_attr_fan2_input);
 		device_create_file(&new_client->dev, &dev_attr_fan2_min);
 		device_create_file(&new_client->dev, &dev_attr_fan2_div);
@@ -452,15 +467,13 @@
 		dev_dbg(&new_client->dev, "Fan 2 not enabled by hardware, "
 			"skipping\n");
 
-	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(0)) & 0x05)
-	    = 0x04) {
+	if (pwm1) {
 		device_create_file(&new_client->dev, &dev_attr_pwm1);
 		device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
 	} else
 		dev_dbg(&new_client->dev, "PWM 1 not enabled by hardware, "
 			"skipping\n");
-	if ((smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
-	    = 0x04) {
+	if (pwm2) {
 		device_create_file(&new_client->dev, &dev_attr_pwm2);
 		device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
 	} else

-- 
Jean Delvare
http://khali.linux-fr.org/
