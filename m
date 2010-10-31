From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sun, 31 Oct 2010 07:50:30 +0000
Subject: [lm-sensors] [PATCH 4/8] hwmon: applesmc: Handle new temperature
Message-Id: <1288511434-5662-5-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The recent Macbooks have temperature registers of a new type.
This patch adds the logic to handle them.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 0207618..ec92aff 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -733,13 +733,19 @@ static ssize_t applesmc_show_temperature(struct device *dev,
 	ret = applesmc_get_entry_by_index(index, &entry);
 	if (ret)
 		return ret;
+	if (entry.len > 2)
+		return -EINVAL;
 
-	ret = applesmc_read_entry(&entry, buffer, 2);
+	ret = applesmc_read_entry(&entry, buffer, entry.len);
 	if (ret)
 		return ret;
 
-	temp = buffer[0]*1000;
-	temp += (buffer[1] >> 6) * 250;
+	if (entry.len = 2) {
+		temp = buffer[0]*1000;
+		temp += (buffer[1] >> 6) * 250;
+	} else {
+		temp = buffer[0] * 4000;
+	}
 
 	return snprintf(sysfsbuf, PAGE_SIZE, "%u\n", temp);
 }
-- 
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
