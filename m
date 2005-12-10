From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 10 Dec 2005 06:43:29 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <439A7911.5020904@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, everyone

back in pre-14 days, I proposed a set of patches to hwmon/pc87360.c
Id like to revisit the parts that didnt make it into 2.6.14,
and see whether it might be consistent with some of Greg KHs
longer term plans for sysfs rework  LWN 12/1

So, attached (sorry) is a patch (for discussion purposes), doing:

hwmon-sysfs.h:

gets a new __SENSOR_DEVICE_ATTR, which expands into an initialization, 
like so:

+#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)    \
+struct sensor_device_attribute sensor_dev_attr_##_name         \
+       = __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)


pc87360.c:

replaces many uses of SENSOR_DEVICE_ATTR with
struct sensor_device_attribute array[] = { ..} 
declarations and initializations using the new macro,
and rolls lists of device_create_file into loops over those arrays.

Also includes a few macros that probly arent general enough for a .h,
but are useful abbreviations here


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff.SDA-1-okcomp
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051210/0b08065c/diff-0001.pl
