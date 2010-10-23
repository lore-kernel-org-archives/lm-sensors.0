From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Sat, 23 Oct 2010 13:39:44 +0000
Subject: [lm-sensors] [PATCHv2] hwmon: lis3: Short explanations of platform
Message-Id: <1287841184-4871-1-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CC1BAEE.3030708@cam.ac.uk>
In-Reply-To: <4CC1BAEE.3030708-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Short documentation at kernel doc format.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 include/linux/lis3lv02d.h |   46 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/include/linux/lis3lv02d.h b/include/linux/lis3lv02d.h
index c949612..d4292c8 100644
--- a/include/linux/lis3lv02d.h
+++ b/include/linux/lis3lv02d.h
@@ -1,6 +1,52 @@
 #ifndef __LIS3LV02D_H_
 #define __LIS3LV02D_H_
 
+/**
+ * struct lis3lv02d_platform_data - lis3 chip family platform data
+ * @click_flags:	Click detection unit configuration
+ * @click_thresh_x:	Click detection unit x axis threshold
+ * @click_thresh_y:	Click detection unit y axis threshold
+ * @click_thresh_z:	Click detection unit z axis threshold
+ * @click_time_limit:	Click detection unit time parameter
+ * @click_latency:	Click detection unit latency parameter
+ * @click_window:	Click detection unit window parameter
+ * @irq_cfg:		On chip irq source and type configuration (click /
+ *			data available / wake up, open drain, polarity)
+ * @irq_flags1:		Additional irq triggering flags for irq channel 0
+ * @irq_flags2:		Additional irq triggering flags for irq channel 1
+ * @duration1:		Wake up unit 1 duration parameter
+ * @duration2:		Wake up unit 2 duration parameter
+ * @wakeup_flags:	Wake up unit 1 flags
+ * @wakeup_thresh:	Wake up unit 1 threshold value
+ * @wakeup_flags2:	Wake up unit 2 flags
+ * @wakeup_thresh2:	Wake up unit 2 threshold value
+ * @hipass_ctrl:	High pass filter control (enable / disable, cut off
+ *			frequency)
+ * @axis_x:		Sensor orientation remapping for x-axis
+ * @axis_y:		Sensor orientation remapping for y-axis
+ * @axis_z:		Sensor orientation remapping for z-axis
+ * @driver_features:	Enable bits for different features. Disabled by default
+ * @default_rate:	Default sampling rate. 0 means reset default
+ * @setup_resources:	Interrupt line setup call back function
+ * @release_resources:	Interrupt line release call back function
+ * @st_min_limits[3]:	Selftest acceptance minimum values
+ * @st_max_limits[3]:	Selftest acceptance maximum values
+ * @irq2:		Irq line 2 number
+ *
+ * Platform data is used to setup the sensor chip. Meaning of the different
+ * chip features can be found from the data sheet. It is publicly available
+ * at www.st.com web pages. Currently the platform data is used
+ * only for the 8 bit device. The 8 bit device has two wake up / free fall
+ * detection units and click detection unit. There are plenty of ways to
+ * configure the chip which makes is quite hard to explain deeper meaning of
+ * the fields here. Behaviour of the detection blocks varies heavily depending
+ * on the configuration. For example, interrupt detection block can use high
+ * pass filtered data which makes it react to the changes in the acceleration.
+ * Irq_flags can be used to enable interrupt detection on the both edges.
+ * With proper chip configuration this produces interrupt when some trigger
+ * starts and when it goes away.
+ */
+
 struct lis3lv02d_platform_data {
 	/* please note: the 'click' feature is only supported for
 	 * LIS[32]02DL variants of the chip and will be ignored for
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
