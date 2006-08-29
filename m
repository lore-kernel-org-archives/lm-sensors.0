From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:25:23 +0000
Subject: [lm-sensors] patch hwmon-it87-set-fan-div.patch added to gregkh-2.6
Message-Id: <20060829232626.593F0808ABE@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 08/14] it87: Cleanup set_fan_div

to my gregkh-2.6 tree.  Its filename is

     hwmon-it87-set-fan-div.patch

This tree can be found at=20
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:35:53 2006
Date: Mon, 28 Aug 2006 14:35:46 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 08/14] it87: Cleanup set_fan_div
Message-Id: <20060828143546.9d439cf8.khali at linux-fr.org>
Content-Disposition: inline; filename=3Dhwmon-it87-set-fan-div.patch

it87: Cleanup set_fan_div

We only change one fan clock divider at a time, so there is only one
fan min which needs to be saved and restored.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/it87.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/it87.c
+++ gregkh-2.6/drivers/hwmon/it87.c
@@ -563,14 +563,14 @@ static ssize_t set_fan_div(struct device
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
-	int i, min[3];
+	int min;
 	u8 old;
=20
 	mutex_lock(&data->update_lock);
 	old =3D it87_read_value(client, IT87_REG_FAN_DIV);
=20
-	for (i =3D 0; i < 3; i++)
-		min[i] =3D FAN_FROM_REG(data->fan_min[i], DIV_FROM_REG(data->fan_div[i])=
);
+	/* Save fan min limit */
+	min =3D FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
=20
 	switch (nr) {
 	case 0:
@@ -590,10 +590,10 @@ static ssize_t set_fan_div(struct device
 		val |=3D 0x1 << 6;
 	it87_write_value(client, IT87_REG_FAN_DIV, val);
=20
-	for (i =3D 0; i < 3; i++) {
-		data->fan_min[i]=FAN_TO_REG(min[i], DIV_FROM_REG(data->fan_div[i]));
-		it87_write_value(client, IT87_REG_FAN_MIN(i), data->fan_min[i]);
-	}
+	/* Restore fan min limit */
+	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+
 	mutex_unlock(&data->update_lock);
 	return count;
 }


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org a=
re

i2c/hwmon-w83627ehf-add-pwm-support.patch
i2c/hwmon-w83627ehf-documentation.patch
i2c/i2c-algo-bit-kill-mdelay.patch
i2c/hwmon-abituguru-suspend-resume.patch
i2c/i2c-__must_check-fixes-i2c-dev.patch
i2c/i2c-__must_check-fixes.patch
i2c/hwmon-it87-disabled-fans.patch
i2c/i2c-algo-sibyte-cleanups.patch
i2c/i2c-algo-sibyte-merge-in-i2c-sibyte.patch
i2c/i2c-au1550-add-au1200-support.patch
i2c/i2c-au1550-add-smbus-functionality-flag.patch
i2c/i2c-au1550-fix-timeout-problem.patch
i2c/i2c-bus-driver-for-TI-OMAP-boards.patch
i2c/i2c-isa-plan-for-removal.patch
i2c/i2c-dev-cleanups.patch
i2c/i2c-dev-convert-array-to-list.patch
i2c/i2c-dev-drop-template-client.patch
i2c/i2c-dev-device.patch
i2c/i2c-fix-copy-n-paste-in-subsystem-Kconfig.patch
i2c/i2c-matroxfb-c99-struct-init.patch
i2c/i2c-sibyte-drop-kip-walker-address.patch
i2c/i2c-stub-add-chip_addr-param.patch
i2c/hwmon-atxp1-signed-unsigned-char-bug.patch
i2c/hwmon-hdaps-handle-errors-from-input-register-device.patch
i2c/hwmon-it87-copyright-update.patch
i2c/hwmon-it87-div-to-reg-overflow.patch
i2c/hwmon-it87-in8-no-limits.patch
i2c/hwmon-it87-it8716f-support.patch
i2c/hwmon-it87-it8718f-support.patch
i2c/hwmon-it87-sane-limit-defaults.patch
i2c/hwmon-it87-set-fan-div.patch
i2c/hwmon-k8temp-autoload.patch
i2c/hwmon-k8temp-new-driver.patch
i2c/hwmon-smsc47m1-fix-dev-message.patch

