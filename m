From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 06:59:20 +0000
Subject: [lm-sensors] patch hwmon-k8temp-documentation.patch added to
Message-Id: <20060928065917.CC54D90221A@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 01/23] k8temp: Add documentation

to my gregkh-2.6 tree.  Its filename is

     hwmon-k8temp-documentation.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 11:51:04 2006
Date: Sun, 24 Sep 2006 20:50:57 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Rudolf Marek <r.marek at sh.cvut.cz>
Subject: [PATCH 01/23] k8temp: Add documentation
Message-Id: <20060924205057.ce05687a.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-k8temp-documentation.patch

From: Rudolf Marek <r.marek at sh.cvut.cz>

k8temp: Add documentation

Add promised documentation for the k8temp driver.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 Documentation/hwmon/k8temp |   52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

--- /dev/null
+++ gregkh-2.6/Documentation/hwmon/k8temp
@@ -0,0 +1,52 @@
+Kernel driver k8temp
+==========
+
+Supported chips:
+  * AMD K8 CPU
+    Prefix: 'k8temp'
+    Addresses scanned: PCI space
+    Datasheet: http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
+
+Author: Rudolf Marek
+Contact: Rudolf Marek <r.marek at sh.cvut.cz>
+
+Description
+-----------
+
+This driver permits reading temperature sensor(s) embedded inside AMD K8 CPUs.
+Official documentation says that it works from revision F of K8 core, but
+in fact it seems to be implemented for all revisions of K8 except the first
+two revisions (SH-B0 and SH-B3).
+
+There can be up to four temperature sensors inside single CPU. The driver
+will auto-detect the sensors and will display only temperatures from
+implemented sensors.
+
+Mapping of /sys files is as follows:
+
+temp1_input - temperature of Core 0 and "place" 0
+temp2_input - temperature of Core 0 and "place" 1
+temp3_input - temperature of Core 1 and "place" 0
+temp4_input - temperature of Core 1 and "place" 1
+
+Temperatures are measured in degrees Celsius and measurement resolution is
+1 degree C. It is expected that future CPU will have better resolution. The
+temperature is updated once a second. Valid temperatures are from -49 to
+206 degrees C.
+
+Temperature known as TCaseMax was specified for processors up to revision E.
+This temperature is defined as temperature between heat-spreader and CPU
+case, so the internal CPU temperature supplied by this driver can be higher.
+There is no easy way how to measure the temperature which will correlate
+with TCaseMax temperature.
+
+For newer revisions of CPU (rev F, socket AM2) there is a mathematically
+computed temperature called TControl, which must be lower than TControlMax.
+
+The relationship is following:
+
+temp1_input - TjOffset*2 < TControlMax,
+
+TjOffset is not yet exported by the driver, TControlMax is usually
+70 degrees C. The rule of the thumb -> CPU temperature should not cross
+60 degrees C too much.


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

