From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 22 Mar 2016 22:18:20 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: Update mailing list and web page for hwmon subsystem
Message-Id: <1458685100-26353-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-hwmon@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>

The old web page for the hwmon subsystem is no longer operational,
and the mailing list has become unreliable. Move both to kernel.org.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS | 96 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f3063cce44c..58ace0467ac0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -228,13 +228,13 @@ F:	kernel/sys_ni.c
 
 ABIT UGURU 1,2 HARDWARE MONITOR DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/abituguru.c
 
 ABIT UGURU 3 HARDWARE MONITOR DRIVER
 M:	Alistair John Strachan <alistair@devzero.co.uk>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/abituguru3.c
 
@@ -392,14 +392,14 @@ F:	Documentation/devicetree/bindings/net/ieee802154/adf7242.txt
 
 ADM1025 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/adm1025
 F:	drivers/hwmon/adm1025.c
 
 ADM1029 HARDWARE MONITOR DRIVER
 M:	Corentin Labbe <clabbe.montjoie@gmail.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/adm1029.c
 
@@ -444,7 +444,7 @@ F:	drivers/video/backlight/adp8860_bl.c
 
 ADS1015 HARDWARE MONITOR DRIVER
 M:	Dirk Eibach <eibach@gdsys.de>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/ads1015
 F:	drivers/hwmon/ads1015.c
@@ -457,7 +457,7 @@ F:	drivers/macintosh/therm_adt746x.c
 
 ADT7475 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/adt7475
 F:	drivers/hwmon/adt7475.c
@@ -634,7 +634,7 @@ F:	include/linux/ccp.h
 
 AMD FAM15H PROCESSOR POWER MONITORING DRIVER
 M:	Huang Rui <ray.huang@amd.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	Documentation/hwmon/fam15h_power
 F:	drivers/hwmon/fam15h_power.c
@@ -806,7 +806,7 @@ F:	drivers/input/mouse/bcm5974.c
 
 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Odd fixes
 F:	drivers/hwmon/applesmc.c
 
@@ -1865,7 +1865,7 @@ F:	include/media/i2c/as3645a.h
 
 ASC7621 HARDWARE MONITOR DRIVER
 M:	George Joseph <george.joseph@fairview5.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/asc7621
 F:	drivers/hwmon/asc7621.c
@@ -1958,7 +1958,7 @@ F:	drivers/net/wireless/ath/carl9170/
 
 ATK0110 HWMON DRIVER
 M:	Luca Tettamanti <kronos.it@gmail.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/asus_atk0110.c
 
@@ -3094,7 +3094,7 @@ F:	mm/swap_cgroup.c
 
 CORETEMP HARDWARE MONITORING DRIVER
 M:	Fenghua Yu <fenghua.yu@intel.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/coretemp
 F:	drivers/hwmon/coretemp.c
@@ -3683,7 +3683,7 @@ T:	git git://git.infradead.org/users/vkoul/slave-dma.git
 
 DME1737 HARDWARE MONITOR DRIVER
 M:	Juerg Haefliger <juergh@gmail.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/dme1737
 F:	drivers/hwmon/dme1737.c
@@ -4381,7 +4381,7 @@ F:	include/video/exynos_mipi*
 
 F71805F HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/f71805f
 F:	drivers/hwmon/f71805f.c
@@ -4460,7 +4460,7 @@ F:	fs/*
 
 FINTEK F75375S HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	Riku Voipio <riku.voipio@iki.fi>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/f75375s.c
 F:	include/linux/f75375s.h
@@ -5021,8 +5021,8 @@ F:	drivers/media/usb/hackrf/
 HARDWARE MONITORING
 M:	Jean Delvare <jdelvare@suse.com>
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
-W:	http://www.lm-sensors.org/
+L:	linux-hwmon@vger.kernel.org
+W:	http://hwmon.wiki.kernel.org/
 T:	quilt http://jdelvare.nerim.net/devel/linux/jdelvare-hwmon/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 S:	Maintained
@@ -5554,7 +5554,7 @@ F:	drivers/usb/atm/ueagle-atm.c
 
 INA209 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/ina209
 F:	Documentation/devicetree/bindings/i2c/ina209.txt
@@ -5562,7 +5562,7 @@ F:	drivers/hwmon/ina209.c
 
 INA2XX HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/ina2xx
 F:	drivers/hwmon/ina2xx.c
@@ -6057,7 +6057,7 @@ F:	drivers/isdn/hardware/eicon/
 
 IT87 HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/it87
 F:	drivers/hwmon/it87.c
@@ -6093,7 +6093,7 @@ F:	drivers/media/dvb-frontends/ix2505v*
 
 JC42.4 TEMPERATURE SENSOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/jc42.c
 F:	Documentation/hwmon/jc42
@@ -6143,14 +6143,14 @@ F:	drivers/tty/serial/jsm/
 
 K10TEMP HARDWARE MONITORING DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/k10temp
 F:	drivers/hwmon/k10temp.c
 
 K8TEMP HARDWARE MONITORING DRIVER
 M:	Rudolf Marek <r.marek@assembler.cz>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/k8temp
 F:	drivers/hwmon/k8temp.c
@@ -6683,27 +6683,27 @@ F:	net/llc/
 
 LM73 HARDWARE MONITOR DRIVER
 M:	Guillaume Ligneul <guillaume.ligneul@gmail.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/lm73.c
 
 LM78 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/lm78
 F:	drivers/hwmon/lm78.c
 
 LM83 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/lm83
 F:	drivers/hwmon/lm83.c
 
 LM90 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/lm90
 F:	Documentation/devicetree/bindings/hwmon/lm90.txt
@@ -6711,7 +6711,7 @@ F:	drivers/hwmon/lm90.c
 
 LM95234 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/lm95234
 F:	drivers/hwmon/lm95234.c
@@ -6777,7 +6777,7 @@ F:	drivers/scsi/sym53c8xx_2/
 
 LTC4261 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/ltc4261
 F:	drivers/hwmon/ltc4261.c
@@ -6947,28 +6947,28 @@ F:	include/uapi/linux/matroxfb.h
 
 MAX16065 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/max16065
 F:	drivers/hwmon/max16065.c
 
 MAX20751 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/max20751
 F:	drivers/hwmon/max20751.c
 
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	"Hans J. Koch" <hjk@hansjkoch.de>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/max6650
 F:	drivers/hwmon/max6650.c
 
 MAX6697 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/max6697
 F:	Documentation/devicetree/bindings/i2c/max6697.txt
@@ -7537,7 +7537,7 @@ F:	drivers/scsi/NCR_D700.*
 
 NCT6775 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/nct6775
 F:	drivers/hwmon/nct6775.c
@@ -8327,7 +8327,7 @@ F:	drivers/video/logo/logo_parisc*
 
 PC87360 HARDWARE MONITORING DRIVER
 M:	Jim Cromie <jim.cromie@gmail.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/pc87360
 F:	drivers/hwmon/pc87360.c
@@ -8339,7 +8339,7 @@ F:	drivers/char/pc8736x_gpio.c
 
 PC87427 HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/pc87427
 F:	drivers/hwmon/pc87427.c
@@ -8719,8 +8719,8 @@ F:	drivers/rtc/rtc-puv3.c
 
 PMBUS HARDWARE MONITORING DRIVERS
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
-W:	http://www.lm-sensors.org/
+L:	linux-hwmon@vger.kernel.org
+W:	http://hwmon.wiki.kernel.org/
 W:	http://www.roeck-us.net/linux/drivers/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 S:	Maintained
@@ -8925,7 +8925,7 @@ F:	drivers/media/usb/pwc/*
 
 PWM FAN DRIVER
 M:	Kamil Debski <k.debski@samsung.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/hwmon/pwm-fan.txt
 F:	Documentation/hwmon/pwm-fan
@@ -10240,28 +10240,28 @@ F:	Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
 
 SMM665 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/smm665
 F:	drivers/hwmon/smm665.c
 
 SMSC EMC2103 HARDWARE MONITOR DRIVER
 M:	Steve Glendinning <steve.glendinning@shawell.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/emc2103
 F:	drivers/hwmon/emc2103.c
 
 SMSC SCH5627 HARDWARE MONITOR DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	Documentation/hwmon/sch5627
 F:	drivers/hwmon/sch5627.c
 
 SMSC47B397 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/smsc47b397
 F:	drivers/hwmon/smsc47b397.c
@@ -11189,7 +11189,7 @@ F:	include/linux/mmc/sh_mobile_sdhi.h
 
 TMP401 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/tmp401
 F:	drivers/hwmon/tmp401.c
@@ -11941,14 +11941,14 @@ F:	Documentation/networking/vrf.txt
 
 VT1211 HARDWARE MONITOR DRIVER
 M:	Juerg Haefliger <juergh@gmail.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/vt1211
 F:	drivers/hwmon/vt1211.c
 
 VT8231 HARDWARE MONITOR DRIVER
 M:	Roger Lucas <vt8231@hiddenengine.co.uk>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/vt8231.c
 
@@ -11967,21 +11967,21 @@ F:	drivers/w1/
 
 W83791D HARDWARE MONITORING DRIVER
 M:	Marc Hulsman <m.hulsman@tudelft.nl>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/w83791d
 F:	drivers/hwmon/w83791d.c
 
 W83793 HARDWARE MONITORING DRIVER
 M:	Rudolf Marek <r.marek@assembler.cz>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/w83793
 F:	drivers/hwmon/w83793.c
 
 W83795 HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
-L:	lm-sensors@lm-sensors.org
+L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/w83795.c
 
-- 
2.5.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
