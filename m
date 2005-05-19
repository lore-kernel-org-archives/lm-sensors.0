From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: RFC [PATCH 2.6] I2C: w83627ehf: add fan_div no-op store method
Message-Id: <bgt881pvivku9pn8t1bfki4hi8f243n72p@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Jean,

This small patch adds no-op fan_div store method to silence warning 
from 'sensors -s'.  Compile tested.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 w83627ehf.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc4-mm1/drivers/i2c/chips/w83627ehf.c	2005-05-12 21:33:22.000000000 +1000
+++ linux-2.6.12-rc4-mm1b/drivers/i2c/chips/w83627ehf.c	2005-05-13 19:39:00.000000000 +1000
@@ -515,8 +515,15 @@ show_reg_fan##offset##_div(struct device
 { \
 	return show_fan_div(dev, buf, offset - 1); \
 } \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
-		   show_reg_fan##offset##_div, NULL);
+static ssize_t \
+store_reg_fan##offset##_div(struct device *dev, const char *buf, \
+			    size_t count) \
+{ \
+	return count; \
+} \
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
+		   show_reg_fan##offset##_div, \
+		   store_reg_fan##offset##_div);
 
 sysfs_fan_offset(1);
 sysfs_fan_min_offset(1);
