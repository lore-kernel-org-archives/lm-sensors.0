From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jul 2007 18:15:31 +0000
Subject: [lm-sensors] PATCH: hwmon-fscher-bugfix-control-update.patch
Message-Id: <46A39EC3.5070005@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030308010107080802070900"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030308010107080802070900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mark,

Here is another small fscher bugfix for 2.6.23 merging, this was caught by Jean
while reviewing my other bugfix. The driver was updating its copy of the
control register as if it was clear to write, but its regular read/write.
This patch fixes this.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

--------------030308010107080802070900
Content-Type: text/x-patch;
 name="hwmon-fscher-bugfix-control-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-fscher-bugfix-control-update.patch"

Mark,

Here is another small fscher bugfix for 2.6.23 merging, this was caught by Jean
while reviewing my other bugfix. The driver was updating its copy of the
control register as if it was clear to write, but its regular read/write.
This patch fixes this.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22.x86_64/drivers/hwmon/fscher.c~ linux-2.6.22.x86_64/drivers/hwmon/fscher.c
--- linux-2.6.22.x86_64/drivers/hwmon/fscher.c~	2007-07-22 20:11:06.000000000 +0200
+++ linux-2.6.22.x86_64/drivers/hwmon/fscher.c	2007-07-22 20:11:06.000000000 +0200
@@ -599,7 +599,7 @@ static ssize_t set_control(struct i2c_cl
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x01;
 
 	mutex_lock(&data->update_lock);
-	data->global_control &= ~v;
+	data->global_control = v;
 	fscher_write_value(client, reg, v);
 	mutex_unlock(&data->update_lock);
 	return count;

--------------030308010107080802070900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030308010107080802070900--
