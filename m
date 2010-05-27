From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 May 2010 14:33:17 +0000
Subject: [lm-sensors] [PATCH] hwmon: (k8temp) Bypass core swapping on
Message-Id: <20100527163317.5b7c627d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit a2e066bba2aad6583e3ff648bf28339d6c9f0898 introduced core
swapping for CPU models 64 and later. I recently had a report about
a Sempron 3200+, model 95, for which this patch broke temperature
reading. It happens that this is a single-core processor, so the
effect of the swapping was to read the temperature value for a core
that didn't exist, leading to an incorrect value (-49 degrees C.)

Disabling core swapping on singe-core processors should fix this.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Tested-by: Rick Moritz <rhavin@gmx.net>
Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
Cc: stable@kernel.org
---
Andreas, please comment on this. Is my fix correct for all single-core
processors? I have to admit I am surprised that nobody reported this
bug in well over a year if it affects all AM2 and AM3 socket Sempron
processors.

 drivers/hwmon/k8temp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.35-rc0.orig/drivers/hwmon/k8temp.c	2010-05-17 18:42:27.000000000 +0200
+++ linux-2.6.35-rc0/drivers/hwmon/k8temp.c	2010-05-27 16:01:02.000000000 +0200
@@ -120,7 +120,7 @@ static ssize_t show_temp(struct device *
 	int temp;
 	struct k8temp_data *data = k8temp_update_device(dev);
 
-	if (data->swap_core_select)
+	if (data->swap_core_select && (data->sensorsp & SEL_CORE))
 		core = core ? 0 : 1;
 
 	temp = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
