From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:32 +0000
Subject: [lm-sensors] [PATCH 12/39] it87: Overwrite broken default limits
Message-Id: <11594837771197-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

it87: Overwrite broken default limits

Some IT8716F chips where seen with unreasonable defaults for low
voltage and high temperature limits. Overwrite them with sane defaults
so as to not generate meaningless alarms.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/it87.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 956cd55..de62f60 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1202,6 +1202,22 @@ static void it87_init_client(struct i2c_
 		data->manual_pwm_ctl[i] = 0xff;
 	}
 
+	/* Some chips seem to have default value 0xff for all limit
+	 * registers. For low voltage limits it makes no sense and triggers
+	 * alarms, so change to 0 instead. For high temperature limits, it
+	 * means -1 degree C, which surprisingly doesn't trigger an alarm,
+	 * but is still confusing, so change to 127 degrees C. */
+	for (i = 0; i < 8; i++) {
+		tmp = it87_read_value(client, IT87_REG_VIN_MIN(i));
+		if (tmp = 0xff)
+			it87_write_value(client, IT87_REG_VIN_MIN(i), 0);
+	}
+	for (i = 0; i < 3; i++) {
+		tmp = it87_read_value(client, IT87_REG_TEMP_HIGH(i));
+		if (tmp = 0xff)
+			it87_write_value(client, IT87_REG_TEMP_HIGH(i), 127);
+	}
+
 	/* Check if temperature channnels are reset manually or by some reason */
 	tmp = it87_read_value(client, IT87_REG_TEMP_ENABLE);
 	if ((tmp & 0x3f) = 0) {
-- 
1.4.2.1


