From: gregkh@suse.de (gregkh@suse.de)
Date: Tue, 16 Aug 2005 08:35:18 +0000
Subject: [lm-sensors] patch hwmon-maintainer.patch added to gregkh-2.6 tree
Message-Id: <1E4v1v-08v-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATHC 2.6] hwmon: separate maintainer

to my gregkh-2.6 tree.  Its filename is

     hwmon-maintainer.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-max6875-documentation-update.patch
i2c/i2c-max6875-simplify.patch
i2c/hwmon-lm85-cleanups.patch
i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch
i2c/i2c-nforce2-cleanup.patch
i2c/i2c-hwmon-split-01.patch
i2c/i2c-hwmon-split-02.patch
i2c/i2c-hwmon-split-03.patch
i2c/i2c-hwmon-split-04.patch
i2c/i2c-hwmon-split-05.patch
i2c/i2c-hwmon-split-06.patch
i2c/i2c-hwmon-split-07.patch
i2c/i2c-hwmon-split-08.patch
i2c/i2c-hwmon-split-09.patch
i2c/i2c-max6875-cleanup.patch
i2c/i2c-max6875-documentation-cleanup.patch
i2c/i2c-max6875-kobj_to_i2c_client.patch
i2c/hwmon-move-SENSORS_LIMIT.patch
i2c/i2c-core-debug-cleanup.patch
i2c/i2c-refactor-message.patch
i2c/i2c-hwmon-document-w83627ehg.patch
i2c/i2c-hwmon-lm78-j.patch
i2c/i2c-hwmon-soften-lm75.patch
i2c/i2c-hwmon-tag-superio-functions-__init.patch
i2c/i2c-documentation-typo.patch
i2c/i2c-inline-i2c_adapter_id.patch
i2c/hwmon-split-round2-01.patch
i2c/hwmon-split-round2-02.patch
i2c/hwmon-split-round2-03.patch
i2c/hwmon-split-round2-04.patch
i2c/hwmon-split-round2-05.patch
i2c/hwmon-split-round2-06.patch
i2c/hwmon-split-round2-07.patch
i2c/hwmon-split-round2-08.patch
i2c/hwmon-split-round2-09.patch
i2c/hwmon-split-round2-10.patch
i2c/hwmon-split-round2-11.patch
i2c/i2c-centralize-24rf08-corruption-prevention.patch
i2c/i2c-rewrite-i2c_probe.patch
i2c/i2c-kill-i2c_algorithm-stuff-01.patch
i2c/i2c-kill-i2c_algorithm-stuff-02.patch
i2c/i2c-kill-i2c_algorithm-stuff-03.patch
i2c/i2c-kill-i2c_algorithm-stuff-04.patch
i2c/i2c-kill-i2c_algorithm-stuff-05.patch
i2c/i2c-kill-i2c_algorithm-stuff-06.patch
i2c/i2c-kill-i2c_algorithm-stuff-07.patch
i2c/i2c-outdated-i2c_adapter-comment.patch
i2c/hwmon-maintainer.patch
i2c/i2c-drop-i2c_clientname.patch


From khali@linux-fr.org Mon Aug 15 10:52:16 2005
Date: Mon, 15 Aug 2005 19:51:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>
Subject: [PATHC 2.6] hwmon: separate maintainer
Message-Id: <20050815195102.0bdcfcfb.khali@linux-fr.org>

Now that the hardware monitoring drivers are no more part of the i2c
subsystem, they probably deserve their own entry in MAINTAINERS.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 MAINTAINERS |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/MAINTAINERS	2005-08-15 23:32:55.000000000 -0700
+++ gregkh-2.6/MAINTAINERS	2005-08-15 23:33:33.000000000 -0700
@@ -933,6 +933,13 @@
 W:	http://www.kernel.org/pub/linux/utils/net/hdlc/
 S:	Maintained
 
+HARDWARE MONITORING
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	lm-sensors@lm-sensors.org
+W:	http://www.lm-sensors.nu/
+S:	Maintained
+
 HARMONY SOUND DRIVER
 P:	Kyle McMartin
 M:	kyle@parisc-linux.org
@@ -1007,7 +1014,7 @@
 M:	wli@holomorphy.com
 S:	Maintained
 
-I2C AND SENSORS DRIVERS
+I2C SUBSYSTEM
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
 P:	Jean Delvare
