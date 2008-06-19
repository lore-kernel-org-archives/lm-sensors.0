From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 19 Jun 2008 13:53:31 +0000
Subject: Re: [lm-sensors] pc87360 and individual alarm files
Message-Id: <485A64DB.3080608@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090907080501030902060006"
List-Id: <lm-sensors.vger.kernel.org>
References: <20080213143140.49a511cc@hyperion.delvare>
In-Reply-To: <20080213143140.49a511cc@hyperion.delvare>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090907080501030902060006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Jim,
>
> On Wed, 05 Mar 2008 15:25:27 -0700, Jim Cromie wrote:
>   
>> Jean Delvare wrote:
>>     
>>> Hi Jim,
>>>
>>> According to my records, all the hardware monitoring drivers have now
>>> been updated to implement individual alarm files, except pc87360. I
>>> know that you had been working on this several months ago. Do you have
>>> an updated patch that I could review?
>>>
>>> Thanks,
>>>   
>>>       
>> Hi Jean,
>>
>> Given enough time, I can do (and presuming I can eventually fix the NFS
>> issue, test) the pc87360 conversion, are you ok with my constraints ?
>>     
>
> Totally fine with me, I don't have time to work on it myself, and no
> test hardware, so even if it takes some time, your help is very
> appreciated.
>
>   
Hi Jean, everyone,

Ok, 3 months later, I have something.

0001-Add-CHAN_-constants-to-support-ALM_-MIN-MAX-CRIT-s.patch
0002-Add-vin-min-max-alarm-sysfs-file-decls-and-callbacks.patch
0003-Add-separate-tempX_min-max-crit_alarm-sysfs-files.patch  
0004-add-LDNI_MAX-constant-for-3-Logical-Devices-we-handl.patch
0005-Add-dev_dbg-calls-to-show-status-regs-at-module-lo.patch  


The in-min/max-alarms work
- setting in-max above and below in-input affects in-max-alarm as expected
- when exceeding threshold, turns on at next read
- returning to inrange, alarm clears after 1 read
- curiously, chip cannot report in-min-alarm when the in-max-alarm is 
set - good its not opposite


For some reason, Temp alarm files dont work,

- /usr/bin/sensors still does, I surmise it must be setting alarms itself

        with last patch, and DEBUG turned on, it looks like this

modprobe pc87360 init=2
[90034.705704] pc87360: Device 0x09 not activated
[90034.722795] pc87360 pc87360.26144: Using external reference voltage
[90034.763100] pc87360 pc87360.26144: VLM conversion set to 1s period, 
160us delay
[90034.792157] pc87360 pc87360.26144: bios vin/temp 0 status:0x91
[90034.808967] pc87360 pc87360.26144: bios vin/temp 1 status:0x91
[90034.828156] pc87360 pc87360.26144: bios vin/temp 2 status:0x91
[90034.851950] pc87360 pc87360.26144: bios vin/temp 3 status:0x91
[90034.874978] pc87360 pc87360.26144: bios vin/temp 4 status:0x91
[90034.888154] pc87360 pc87360.26144: bios vin/temp 5 status:0x91
[90034.904685] pc87360 pc87360.26144: bios vin/temp 6 status:0x91
[90034.920169] pc87360 pc87360.26144: bios vin/temp 7 status:0x91
[90034.948144] pc87360 pc87360.26144: bios vin/temp 8 status:0x93
[90034.968163] pc87360 pc87360.26144: bios vin/temp 9 status:0x00
[90034.982814] pc87360 pc87360.26144: bios vin/temp 10 status:0x91
[90035.000154] pc87360 pc87360.26144: bios temp11_status:0x00 thermistors:0
[90035.034434] pc87360 pc87360.26144: bios temp12_status:0x00 thermistors:0
[90035.043426] pc87360 pc87360.26144: bios temp13_status:0x00 thermistors:0
[90035.055799] pc87360 pc87360.26144: bios temp0_status:0xcd
[90035.067988] pc87360 pc87360.26144: bios temp1_status:0xcd
[90035.121408] pc87360 pc87360.26144: bios temp2_status:0x8d
[90035.132146] pc87360 pc87360.26144: bios vin-cfg:0x02
[90035.140150] pc87360 pc87360.26144: bios temp-cfg:0x02
soekris:~#

I suspect this might be due to the status for temp0-2, the CHAN_ALM_ENA 
bit is not set.
That said, it didnt work when I tried it ( patch held back cuz of this )

The patches elicit minor complaints from checkpatch; no signoff, lines 
over 80 chars.
Some of these can be fixed by editing the patches, but :

- might get rejected on bad index vs contents
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 9b462bb..8f13bed 100644

-  submitting (modded) diffs feels wrong - it means Im testing slightly 
different code,
Or it requires me to create another branch and apply the series there ( 
git-format-patch makes > diffs easy )

So whats the most efficient way to do things in this brave new git world ?
- start a new branch,
- apply each patch one at a time, then do requested mods and commit,

I did 1 lap of cleanup like this already, I tried git rebase interactively,
but ended up using git cherry-pick to replay the useful patches after 
consulting a saved git-log


Anyway..


[jimc@harpo linux-2.6]$ git log --stat
commit 0f23f42ec15cccd02011b6f80ea7466ce6e60f73
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Wed Jun 18 00:17:55 2008 -0600

    Add dev_dbg() calls to show status regs at module load.
   
    Channel status register values may be set by chip specifications,
    set again by bios, or by this previously loaded driver.
    My bios (soekris 4801, with TinyBIOS I think) sets CHAN_ALM_ENA
    on vin channels, but not on temp channels.

 drivers/hwmon/pc87360.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

commit 51bbd9b8116021dcd6a5c4b204efa46319ddab2a
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Sun Jun 15 09:22:35 2008 -0600

    add LDNI_MAX constant for 3 Logical Devices we handle
   
    Driver handles 3 logical units, make that a little clearer.

 drivers/hwmon/pc87360.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

commit dcf9aeb53c4fdb08d3f9744911b552b18047edca
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Tue Jun 17 23:22:05 2008 -0600

    Add separate tempX_min/max/crit_alarm sysfs-files
   
    Add sysfs-files and callbacks for temp-min/max/crit-alarms
    and temp-faults.

 drivers/hwmon/pc87360.c |   82 
+++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 79 insertions(+), 3 deletions(-)

commit ec7741290d780195d04bfde0840680ca6def8abc
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Tue Jun 17 22:21:58 2008 -0600

    Add vin-min/max-alarm sysfs-file decls and callbacks

 drivers/hwmon/pc87360.c |   52 
++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

commit dcc726a8356bf76ab666d3e86a7fe3bddb2a4dfa
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Tue Jun 17 21:59:09 2008 -0600

    Add CHAN_* constants to support ALM_(MIN|MAX|CRIT) sys-files
   
    2 different kinds of constants added:
    - CHAN_ALM_* constants for (later) vin, temp alarm callbacks.
    - CHAN_* conversion constants, used in _init_device, partly for RW1C 
bits

 drivers/hwmon/pc87360.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

commit c8988f968240069aeae16d8cf9f59096a085eb27
Merge: 10acaf0... 732a675...
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Jun 16 11:52:43 2008 -0700

    Merge branch 'release' of 
git://git.kernel.org/pub/scm/linux/kernel/git/aegl
   


--------------090907080501030902060006
Content-Type: text/x-patch;
	name="0001-Add-CHAN_-constants-to-support-ALM_-MIN-MAX-CRIT-s.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-Add-CHAN_-constants-to-support-ALM_-MIN-MAX-CRIT-s.patc";
	filename*1="h"

From dcc726a8356bf76ab666d3e86a7fe3bddb2a4dfa Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 17 Jun 2008 21:59:09 -0600
Subject: [PATCH] Add CHAN_* constants to support ALM_(MIN|MAX|CRIT) sys-files

2 different kinds of constants added:
- CHAN_ALM_* constants for (later) vin, temp alarm callbacks.
- CHAN_* conversion constants, used in _init_device, partly for RW1C bits
---
 drivers/hwmon/pc87360.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 9b462bb..8f13bed 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -489,6 +489,11 @@ static struct sensor_device_attribute in_max[] = {
 	SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
 };
 
+/* (temp & vin) channel status register alarm bits (pdf sec.11.5.12) */
+#define CHAN_ALM_MIN	0x02	/* min limit crossed */
+#define CHAN_ALM_MAX	0x04	/* max limit exceeded */
+#define TEMP_ALM_CRIT	0x08	/* temp crit exceeded (temp only, reserved in vin) */
+
 #define VIN_UNIT_ATTRS(X) \
 	&in_input[X].dev_attr.attr,	\
 	&in_status[X].dev_attr.attr,	\
@@ -1131,6 +1136,12 @@ static void pc87360_write_value(struct pc87360_data *data, u8 ldi, u8 bank,
 	mutex_unlock(&(data->lock));
 }
 
+/* (temp & vin) channel conversion status register flags (pdf sec.11.5.12) */
+#define CHAN_CNVRTD	0x80	/* new data ready */
+#define CHAN_ENA	0x01	/* enabled channel (temp or vin) */
+#define CHAN_ALM_ENA	0x10	/* propagate to alarms-reg ?? (chk val!) */
+#define CHAN_READY	(CHAN_ENA|CHAN_CNVRTD) /* sample ready mask */
+
 static void pc87360_init_device(struct platform_device *pdev,
 				int use_thermistors)
 {
@@ -1156,7 +1167,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 			/* Forcibly enable voltage channel */
 			reg = pc87360_read_value(data, LD_IN, i,
 						 PC87365_REG_IN_STATUS);
-			if (!(reg & 0x01)) {
+			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling in%d\n", i);
 				pc87360_write_value(data, LD_IN, i,
@@ -1171,7 +1182,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	for (i = 11; i < data->innr; i++) {
 		reg = pc87360_read_value(data, LD_IN, i,
 					 PC87365_REG_TEMP_STATUS);
-		use_thermistors = use_thermistors || (reg & 0x01);
+		use_thermistors = use_thermistors || (reg & CHAN_ENA);
 	}
 
 	i = use_thermistors ? 2 : 0;
@@ -1180,7 +1191,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 			/* Forcibly enable temperature channel */
 			reg = pc87360_read_value(data, LD_TEMP, i,
 						 PC87365_REG_TEMP_STATUS);
-			if (!(reg & 0x01)) {
+			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling temp%d\n", i+1);
 				pc87360_write_value(data, LD_TEMP, i,
@@ -1197,7 +1208,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 				   diodes */
 				reg = pc87360_read_value(data, LD_TEMP,
 				      (i-11)/2, PC87365_REG_TEMP_STATUS);
-				if (reg & 0x01) {
+				if (reg & CHAN_ENA) {
 					dev_dbg(&pdev->dev, "Skipping "
 						"temp%d, pin already in use "
 						"by temp%d\n", i-7, (i-11)/2);
@@ -1207,7 +1218,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 				/* Forcibly enable thermistor channel */
 				reg = pc87360_read_value(data, LD_IN, i,
 							 PC87365_REG_IN_STATUS);
-				if (!(reg & 0x01)) {
+				if (!(reg & CHAN_ENA)) {
 					dev_dbg(&pdev->dev, "Forcibly "
 						"enabling temp%d\n", i-7);
 					pc87360_write_value(data, LD_IN, i,
@@ -1221,7 +1232,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (data->innr) {
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONFIG);
-		if (reg & 0x01) {
+		if (reg & CHAN_ENA) {
 			dev_dbg(&pdev->dev, "Forcibly "
 				"enabling monitoring (VLM)\n");
 			pc87360_write_value(data, LD_IN, NO_BANK,
@@ -1233,7 +1244,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (data->tempnr) {
 		reg = pc87360_read_value(data, LD_TEMP, NO_BANK,
 					 PC87365_REG_TEMP_CONFIG);
-		if (reg & 0x01) {
+		if (reg & CHAN_ENA) {
 			dev_dbg(&pdev->dev, "Forcibly enabling "
 				"monitoring (TMS)\n");
 			pc87360_write_value(data, LD_TEMP, NO_BANK,
@@ -1336,11 +1347,11 @@ static struct pc87360_data *pc87360_update_device(struct device *dev)
 			pc87360_write_value(data, LD_IN, i,
 					    PC87365_REG_IN_STATUS,
 					    data->in_status[i]);
-			if ((data->in_status[i] & 0x81) == 0x81) {
+			if ((data->in_status[i] & CHAN_READY) == CHAN_READY) {
 				data->in[i] = pc87360_read_value(data, LD_IN,
 					      i, PC87365_REG_IN);
 			}
-			if (data->in_status[i] & 0x01) {
+			if (data->in_status[i] & CHAN_ENA) {
 				data->in_min[i] = pc87360_read_value(data,
 						  LD_IN, i,
 						  PC87365_REG_IN_MIN);
@@ -1373,12 +1384,12 @@ static struct pc87360_data *pc87360_update_device(struct device *dev)
 			pc87360_write_value(data, LD_TEMP, i,
 					    PC87365_REG_TEMP_STATUS,
 					    data->temp_status[i]);
-			if ((data->temp_status[i] & 0x81) == 0x81) {
+			if ((data->temp_status[i] & CHAN_READY) == CHAN_READY) {
 				data->temp[i] = pc87360_read_value(data,
 						LD_TEMP, i,
 						PC87365_REG_TEMP);
 			}
-			if (data->temp_status[i] & 0x01) {
+			if (data->temp_status[i] & CHAN_ENA) {
 				data->temp_min[i] = pc87360_read_value(data,
 						    LD_TEMP, i,
 						    PC87365_REG_TEMP_MIN);
-- 
1.5.5.1


--------------090907080501030902060006
Content-Type: text/x-patch;
	name="0002-Add-vin-min-max-alarm-sysfs-file-decls-and-callbacks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0002-Add-vin-min-max-alarm-sysfs-file-decls-and-callbacks.pa";
	filename*1="tch"

From ec7741290d780195d04bfde0840680ca6def8abc Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 17 Jun 2008 22:21:58 -0600
Subject: [PATCH] Add vin-min/max-alarm sysfs-file decls and callbacks

---
 drivers/hwmon/pc87360.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 8f13bed..af3b8b8 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -494,11 +494,61 @@ static struct sensor_device_attribute in_max[] = {
 #define CHAN_ALM_MAX	0x04	/* max limit exceeded */
 #define TEMP_ALM_CRIT	0x08	/* temp crit exceeded (temp only, reserved in vin) */
 
+/* show_in_min/max_alarm() reads data from the per-channel status
+   register (sec 11.5.12), not the vin event status registers (sec
+   11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms) */
+
+static ssize_t show_in_min_alarm(struct device *dev, struct device_attribute
+			     *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
+}
+static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute
+			     *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MAX));
+}
+
+static struct sensor_device_attribute in_min_alarm[] = {
+	SENSOR_ATTR(in0_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 0),
+	SENSOR_ATTR(in1_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 1),
+	SENSOR_ATTR(in2_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 2),
+	SENSOR_ATTR(in3_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 3),
+	SENSOR_ATTR(in4_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 4),
+	SENSOR_ATTR(in5_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 5),
+	SENSOR_ATTR(in6_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 6),
+	SENSOR_ATTR(in7_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 7),
+	SENSOR_ATTR(in8_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 8),
+	SENSOR_ATTR(in9_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 9),
+	SENSOR_ATTR(in10_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 10),
+};
+static struct sensor_device_attribute in_max_alarm[] = {
+	SENSOR_ATTR(in0_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 0),
+	SENSOR_ATTR(in1_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 1),
+	SENSOR_ATTR(in2_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 2),
+	SENSOR_ATTR(in3_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 3),
+	SENSOR_ATTR(in4_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 4),
+	SENSOR_ATTR(in5_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 5),
+	SENSOR_ATTR(in6_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 6),
+	SENSOR_ATTR(in7_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 7),
+	SENSOR_ATTR(in8_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 8),
+	SENSOR_ATTR(in9_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 9),
+	SENSOR_ATTR(in10_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 10),
+};
+
 #define VIN_UNIT_ATTRS(X) \
 	&in_input[X].dev_attr.attr,	\
 	&in_status[X].dev_attr.attr,	\
 	&in_min[X].dev_attr.attr,	\
-	&in_max[X].dev_attr.attr
+	&in_max[X].dev_attr.attr,	\
+	&in_min_alarm[X].dev_attr.attr,	\
+	&in_max_alarm[X].dev_attr.attr
 
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
1.5.5.1


--------------090907080501030902060006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090907080501030902060006--
