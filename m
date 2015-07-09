From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 09 Jul 2015 17:59:11 +0000
Subject: [lm-sensors] [PATCH v3 1/3] i2c: add a protocol parameter to the alert callback
Message-Id: <1436464751-2475-1-git-send-email-benjamin.tissoires@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436463052-6944-2-git-send-email-benjamin.tissoires@redhat.com>
In-Reply-To: <1436463052-6944-2-git-send-email-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Corey Minyard <minyard@acm.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: benjamin.tissoires@gmail.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

.alert() is meant to be generic, but there is currently no way
for the device driver to know which protocol generated the alert.
Add a parameter in .alert() to help the device driver to understand
what is given in data.

This patch is required to have the support of SMBus Host Notify protocol
through .alert().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi again,

of course, you send the patch series[1], switch to something else, and you realize
that you have a new warning...
Sorry, I missed the lm90 driver in the v2.

Adding also in CC the maintainers of LM90 and IPMI.

Cheers,
Benjamin

[1] http://marc.info/?l=linux-i2c&m3646306528808&w=2

new in v2

changes in v3:
- added also lm90.c to support the new API

 drivers/char/ipmi/ipmi_ssif.c | 6 +++++-
 drivers/hwmon/lm90.c          | 3 ++-
 drivers/i2c/i2c-smbus.c       | 3 ++-
 include/linux/i2c.h           | 7 ++++++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 207689c..1d4cece 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -567,12 +567,16 @@ static void retry_timeout(unsigned long data)
 }
 
 
-static void ssif_alert(struct i2c_client *client, unsigned int data)
+static void ssif_alert(struct i2c_client *client,
+		       enum i2c_alert_protocol protocol, unsigned int data)
 {
 	struct ssif_info *ssif_info = i2c_get_clientdata(client);
 	unsigned long oflags, *flags;
 	bool do_get = false;
 
+	if (protocol != I2C_PROTOCOL_SMBUS_ALERT)
+		return;
+
 	ssif_inc_stat(ssif_info, alerts);
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index c9ff08d..2b77dbd 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1624,7 +1624,8 @@ static int lm90_remove(struct i2c_client *client)
 	return 0;
 }
 
-static void lm90_alert(struct i2c_client *client, unsigned int flag)
+static void lm90_alert(struct i2c_client *client, enum i2c_alert_protocol type,
+		       unsigned int flag)
 {
 	u16 alarms;
 
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 94765a8..abad351 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -56,7 +56,8 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	if (client->dev.driver) {
 		driver = to_i2c_driver(client->dev.driver);
 		if (driver->alert)
-			driver->alert(client, data->flag);
+			driver->alert(client, I2C_PROTOCOL_SMBUS_ALERT,
+				      data->flag);
 		else
 			dev_warn(&client->dev, "no driver alert()!\n");
 	} else
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e83a738..6764734 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -123,6 +123,10 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 					  const u8 *values);
 #endif /* I2C */
 
+enum i2c_alert_protocol {
+	I2C_PROTOCOL_SMBUS_ALERT,
+};
+
 /**
  * struct i2c_driver - represent an I2C device driver
  * @class: What kind of i2c device we instantiate (for detect)
@@ -178,7 +182,8 @@ struct i2c_driver {
 	 * For the SMBus alert protocol, there is a single bit of data passed
 	 * as the alert response's low bit ("event flag").
 	 */
-	void (*alert)(struct i2c_client *, unsigned int data);
+	void (*alert)(struct i2c_client *, enum i2c_alert_protocol protocol,
+		      unsigned int data);
 
 	/* a ioctl like command that can be used to perform specific functions
 	 * with the device.
-- 
2.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
