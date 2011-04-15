From: wni@nvidia.com
Date: Fri, 15 Apr 2011 11:00:26 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm90) Add suspend/resume support
Message-Id: <1302865228-7185-2-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302865228-7185-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1302865228-7185-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, guenter.roeck@ericsson.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, olofj@chromium.org, achew@nvidia.com, Wei Ni <wni@nvidia.com>

From: Wei Ni <wni@nvidia.com>

This patch adds suspend/resume support.
Stop lm90 in suspend, and run it in resume.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/hwmon/lm90.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 2f94f95..1c2ee3f 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1085,6 +1085,24 @@ static DEVICE_ATTR(pec, S_IWUSR | S_IRUGO, show_pec, set_pec);
  * Real code
  */
 
+static void lm90_enable(struct i2c_client *client)
+{
+	u8 value;
+
+	lm90_read_reg(client, LM90_REG_R_CONFIG1, &value);
+	value &= ~0x40;
+	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, value);
+}
+
+static void lm90_disable(struct i2c_client *client)
+{
+	u8 value;
+
+	lm90_read_reg(client, LM90_REG_R_CONFIG1, &value);
+	value |= 0x40;
+	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, value);
+}
+
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm90_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
@@ -1482,6 +1500,20 @@ static void lm90_alert(struct i2c_client *client, unsigned int flag)
 	}
 }
 
+#ifdef CONFIG_PM
+static int lm90_suspend(struct i2c_client *client, pm_message_t state)
+{
+	lm90_disable(client);
+	return 0;
+}
+
+static int lm90_resume(struct i2c_client *client)
+{
+	lm90_enable(client);
+	return 0;
+}
+#endif
+
 static struct i2c_driver lm90_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
@@ -1493,6 +1525,10 @@ static struct i2c_driver lm90_driver = {
 	.id_table	= lm90_id,
 	.detect		= lm90_detect,
 	.address_list	= normal_i2c,
+#ifdef CONFIG_PM
+	.suspend	= lm90_suspend,
+	.resume		= lm90_resume,
+#endif
 };
 
 static int __init sensors_lm90_init(void)
-- 
1.7.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
