From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 06:59:30 +0000
Subject: [lm-sensors] patch hwmon-remove-yuan-mu-address.patch added to
Message-Id: <20060928065927.5915590165C@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 23/23] hwmon: Remove Yuan Mu's address

to my gregkh-2.6 tree.  Its filename is

     hwmon-remove-yuan-mu-address.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 12:25:56 2006
Date: Sun, 24 Sep 2006 21:25:52 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 23/23] hwmon: Remove Yuan Mu's address
Message-Id: <20060924212552.84abbf97.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-remove-yuan-mu-address.patch

hwmon: Remove Yuan Mu's address

Yuan Mu no longer works at Winbond.

I wish to publicly thank Yuan for his help with Winbond hardware
monitoring chips support during the past 10 months.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 Documentation/hwmon/w83627ehf |    2 +-
 drivers/hwmon/w83627ehf.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/Documentation/hwmon/w83627ehf
+++ gregkh-2.6/Documentation/hwmon/w83627ehf
@@ -9,7 +9,7 @@ Supported chips:
 
 Authors:
         Jean Delvare <khali at linux-fr.org>
-        Yuan Mu <Ymu at Winbond.com.tw>
+        Yuan Mu (Winbond)
         Rudolf Marek <r.marek at sh.cvut.cz>
 
 Description
--- gregkh-2.6.orig/drivers/hwmon/w83627ehf.c
+++ gregkh-2.6/drivers/hwmon/w83627ehf.c
@@ -2,7 +2,7 @@
     w83627ehf - Driver for the hardware monitoring functionality of
                 the Winbond W83627EHF Super-I/O chip
     Copyright (C) 2005  Jean Delvare <khali at linux-fr.org>
-    Copyright (C) 2006  Yuan Mu <Ymu at Winbond.com.tw>,
+    Copyright (C) 2006  Yuan Mu (Winbond),
                         Rudolf Marek <r.marek at sh.cvut.cz>
                         David Hubbard <david.c.hubbard at gmail.com>
 


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-w83627ehf-add-pwm-support.patch
i2c/hwmon-w83627ehf-documentation.patch
i2c/hwmon-k8temp-documentation.patch
i2c/hwmon-abituguru-suspend-resume.patch
i2c/hwmon-individual-alarm-files-1.patch
i2c/hwmon-kconfig-update.patch
i2c/hwmon-it87-disabled-fans.patch
i2c/hwmon-remove-yuan-mu-address.patch
i2c/hwmon-unchecked-return-status-fixes-1.patch
i2c/hwmon-unchecked-return-status-fixes-2.patch
i2c/hwmon-unchecked-return-status-fixes-3.patch
i2c/hwmon-unchecked-return-status-fixes-4.patch
i2c/hwmon-unchecked-return-status-fixes-5.patch
i2c/hwmon-unchecked-return-status-fixes-6.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-1.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-2.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-3.patch
i2c/hwmon-unchecked-return-status-fixes-smsc.patch
i2c/hwmon-unchecked-return-status-fixes-vt8231.patch
i2c/hwmon-atxp1-signed-unsigned-char-bug.patch
i2c/hwmon-hdaps-handle-errors-from-input-register-device.patch
i2c/hwmon-it87-copyright-update.patch
i2c/hwmon-it87-div-to-reg-overflow.patch
i2c/hwmon-it87-in8-no-limits.patch
i2c/hwmon-it87-it8716f-support.patch
i2c/hwmon-it87-it8718f-support.patch
i2c/hwmon-it87-sane-limit-defaults.patch
i2c/hwmon-it87-set-fan-div.patch
i2c/hwmon-k8temp-autoload.patch
i2c/hwmon-k8temp-new-driver.patch
i2c/hwmon-smsc47m1-fix-dev-message.patch
i2c/hwmon-unchecked-return-status-fixes-w83627ehf.patch
i2c/hwmon-unchecked-return-status-fixes-w83781d.patch
i2c/hwmon-unchecked-return-status-fixes-w83792d.patch
i2c/hwmon-unchecked-return-status-fixes-w83l785ts.patch
i2c/hwmon-vt1211-add-module-parameters-description.patch
i2c/hwmon-vt1211-documentation.patch
i2c/hwmon-vt1211-new-driver.patch
i2c/hwmon-w83791d-doc-update.patch
driver-class/i2c-dev-device.patch
driver-class/i2c-dev-device.old.patch

