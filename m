From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 05 Nov 2011 14:43:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) fix broken driver init
Message-Id: <1320504223-28764-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, stable@kernel.org

Commit 2265cef2 (hwmon: (w83627ehf) Properly report PECI and AMD-SI
sensor types) results in kernel panic if data->temp_label was not
initialized.
The problem was found with chip W83627DHG-P.

Add check if data->temp->label was set before use.

Based on incomplete patch by Alexander Beregalov.

Reported-by: Alexander Beregalov <a.beregalov@gmail.com>
Tested-by: Alexander Beregalov <a.beregalov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: stable@kernel.org
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/w83627ehf.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 483cb26..93f5fc7 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1835,12 +1835,15 @@ static inline void __devinit w83627ehf_init_device(struct w83627ehf_data *data,
 		diode = 0x70;
 	}
 	for (i = 0; i < 3; i++) {
-		const char *label = data->temp_label[data->temp_src[i]];
+		const char *label = NULL;
+
+		if (data->temp_label)
+			label = data->temp_label[data->temp_src[i]];
 
 		/* Digital source overrides analog type */
-		if (strncmp(label, "PECI", 4) = 0)
+		if (label && strncmp(label, "PECI", 4) = 0)
 			data->temp_type[i] = 6;
-		else if (strncmp(label, "AMD", 3) = 0)
+		else if (label && strncmp(label, "AMD", 3) = 0)
 			data->temp_type[i] = 5;
 		else if ((tmp & (0x02 << i)))
 			data->temp_type[i] = (diode & (0x10 << i)) ? 1 : 3;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
