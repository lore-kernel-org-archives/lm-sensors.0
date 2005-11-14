From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 14 Nov 2005 23:11:36 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix lm78 VID conversion
Message-Id: <20051114231145.670478d0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This one is for 2.6.15-rc2, and a candidate for -stable.

Thanks.

* * * * *

Content-Disposition: inline; filename=hwmon-lm78-fix-vid.patch

Fix the lm78 VID reading, which I accidentally broke while making
this driver use the common vid_from_reg function rather than
reimplementing its own in 2.6.14-rc1.

I'm not proud of it, trust me.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---

 drivers/hwmon/lm78.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-rc1.orig/drivers/hwmon/lm78.c	2005-11-14 22:31:06.000000000 +0100
+++ linux-2.6.15-rc1/drivers/hwmon/lm78.c	2005-11-14 22:32:05.000000000 +0100
@@ -451,7 +451,7 @@
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(82, data->vid));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, 82));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 


-- 
Jean Delvare
