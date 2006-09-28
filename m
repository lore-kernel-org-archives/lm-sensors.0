From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 07:01:46 +0000
Subject: [lm-sensors] patch
Message-Id: <20060928070143.84F12890831@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060502054527.8533748769D@imap.suse.de>
In-Reply-To: <20060502054527.8533748769D@imap.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 07/23] vt1211: Document module parameters

to my gregkh-2.6 tree.  Its filename is

     hwmon-vt1211-add-module-parameters-description.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 11:55:42 2006
Date: Sun, 24 Sep 2006 20:55:34 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Juerg Haefliger <juergh at gmail.com>
Subject: [PATCH 07/23] vt1211: Document module parameters
Message-Id: <20060924205534.56a0e585.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-vt1211-add-module-parameters-description.patch

From: Juerg Haefliger <juergh at gmail.com>

vt1211: Document module parameters

Add a description of the module parameters to the documentation of
the vt1211 driver.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 Documentation/hwmon/vt1211 |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/Documentation/hwmon/vt1211
+++ gregkh-2.6/Documentation/hwmon/vt1211
@@ -16,6 +16,26 @@ Thanks to Joseph Chan and Fiona Gatt fro
 technical support.
 
 
+Module Parameters
+-----------------
+
+* uch_config: int	Override the BIOS default universal channel (UCH)
+			configuration for channels 1-5.
+			Legal values are in the range of 0-31. Bit 0 maps to
+			UCH1, bit 1 maps to UCH2 and so on. Setting a bit to 1
+			enables the thermal input of that particular UCH and
+			setting a bit to 0 enables the voltage input.
+
+* int_mode: int		Override the BIOS default temperature interrupt mode.
+			The only possible value is 0 which forces interrupt
+			mode 0. In this mode, any pending interrupt is cleared
+			when the status register is read but is regenerated as
+			long as the temperature stays above the hysteresis
+			limit.
+
+Be aware that overriding BIOS defaults might cause some unwanted side effects!
+
+
 Description
 -----------
 
@@ -88,9 +108,7 @@ has a high limit which triggers an alarm
 hysteresis value with each temperature below which the temperature has to drop
 before the alarm is cleared (this is only true for interrupt mode 0). The
 interrupt mode can be forced to 0 in case the BIOS doesn't do it
-automatically. For that, the parameter int_mode=0 needs to be supplied when
-loading the driver module. Be aware that overriding BIOS defaults might cause
-some unwanted side effects!
+automatically. See the 'Module Parameters' section for details.
 
 All temperature channels except temp2 are external. Temp2 is the VT1211
 internal thermal diode and the driver does all the scaling for temp2 and


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

