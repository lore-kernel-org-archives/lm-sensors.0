From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:39:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: fscher control update bugfix
Message-Id: <1185846001634-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Hans de Goede <j.w.r.degoede@hhs.nl>

Here is another small fscher bugfix for 2.6.23 merging, this was caught by Jean
while reviewing my other bugfix. The driver was updating its copy of the
control register as if it was clear to write, but its regular read/write.  This
patch fixes this.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/fscher.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
index 1971775..f3aa188 100644
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -599,7 +599,7 @@ static ssize_t set_control(struct i2c_client *client, struct fscher_data *data,
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x01;
 
 	mutex_lock(&data->update_lock);
-	data->global_control &= ~v;
+	data->global_control = v;
 	fscher_write_value(client, reg, v);
 	mutex_unlock(&data->update_lock);
 	return count;
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
