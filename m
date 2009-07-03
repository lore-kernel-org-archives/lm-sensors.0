From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 03 Jul 2009 09:24:13 +0000
Subject: Re: [lm-sensors] VID on Intel Core Duo
Message-Id: <20090703112413.05236721@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
In-Reply-To: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Maneki,

On Wed, 1 Jul 2009 13:25:44 -0400, Maneki Neko wrote:
> The Windows program I use to pull the VID is CPUID's CPU-Z program.  It only
> shows one voltage, the "Core VID".  Unfortunately, I don't see anything that
> states what chip it is using.

Maybe because there's no chip but the value is read from the CPU
directly. I have a patch for the coretemp driver, written by Rudolf
Marek long ago, which reads the VID value of Intel Core CPUs. I seem to
remember it worked reasonably well for me. I also seem to remember it
wasn't applied because it makes use of an undocumented register (not
that it has prevented us from releasing the coretemp driver in the
first place, with all the undocumented stuff it uses.)

Please give a try to this patch if you can. If it works OK for you and
others, maybe we can merge it still, unless Rudolf strongly objects.

---
 drivers/hwmon/Kconfig    |    1 +
 drivers/hwmon/coretemp.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

--- linux-2.6.31-rc1.orig/drivers/hwmon/coretemp.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.31-rc1/drivers/hwmon/coretemp.c	2009-07-03 11:00:50.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/hwmon.h>
 #include <linux/sysfs.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -58,6 +59,8 @@ struct coretemp_data {
 	int tjmax;
 	int ttarget;
 	u8 alarm;
+	u8 voltage;
+	u8 vrm;
 };
 
 /*
@@ -86,6 +89,13 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", data->alarm);
 }
 
+static ssize_t show_vid(struct device *dev, struct device_attribute
+			  *devattr, char *buf)
+{
+	struct coretemp_data *data = coretemp_update_device(dev);
+	return sprintf(buf, "%d\n", vid_from_reg(data->voltage, data->vrm));
+}
+
 static ssize_t show_temp(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
@@ -109,6 +119,7 @@ static SENSOR_DEVICE_ATTR(temp1_crit, S_
 static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
 			  SHOW_TTARGET);
 static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
 static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
 
@@ -116,6 +127,7 @@ static struct attribute *coretemp_attrib
 	&sensor_dev_attr_name.dev_attr.attr,
 	&sensor_dev_attr_temp1_label.dev_attr.attr,
 	&dev_attr_temp1_crit_alarm.attr,
+	&dev_attr_cpu0_vid.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	NULL
@@ -135,6 +147,8 @@ static struct coretemp_data *coretemp_up
 		u32 eax, edx;
 
 		data->valid = 0;
+		rdmsr_on_cpu(data->id, MSR_IA32_PERF_STATUS, &eax, &edx);
+		data->voltage = ~eax & 0x3f;
 		rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
 		data->alarm = (eax >> 5) & 1;
 		/* update only if data has been valid */
@@ -215,6 +229,8 @@ static int __devinit coretemp_probe(stru
 		goto exit;
 	}
 
+	/* Get VRM */
+	data->vrm = vid_which_vrm();
 	data->id = pdev->id;
 	data->name = "coretemp";
 	mutex_init(&data->update_lock);
--- linux-2.6.31-rc1.orig/drivers/hwmon/Kconfig	2009-07-03 09:59:58.000000000 +0200
+++ linux-2.6.31-rc1/drivers/hwmon/Kconfig	2009-07-03 11:00:50.000000000 +0200
@@ -403,6 +403,7 @@ config SENSORS_GL520SM
 
 config SENSORS_CORETEMP
 	tristate "Intel Core (2) Duo/Solo temperature sensor"
+	select HWMON_VID
 	depends on X86 && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the temperature

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
