From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 22:25:25 +0000
Subject: [lm-sensors] [PATCH 06/11] w83781d: Document the alarm and beep bits
Message-Id: <20060205232525.4a6377e1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-w83781d-document-alarm-bits.patch

Document the individual alarm and beep bits of the w83781d driver.
Ideally we would offer a chip-independant interface for them, but
until it's done, it's only fair that we document the current
interface.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/w83781d |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- linux-2.6.16-rc2.orig/Documentation/hwmon/w83781d	2006-02-05 15:59:48.000000000 +0100
+++ linux-2.6.16-rc2/Documentation/hwmon/w83781d	2006-02-05 16:01:53.000000000 +0100
@@ -123,6 +123,25 @@
 your computer speaker. It is possible to enable all beeping globally,
 or only the beeping for some alarms.
 
+Individual alarm and beep bits:
+
+0x000001: in0
+0x000002: in1
+0x000004: in2
+0x000008: in3
+0x000010: temp1
+0x000020: temp2 (+temp3 on W83781D)
+0x000040: fan1
+0x000080: fan2
+0x000100: in4
+0x000200: in5
+0x000400: in6
+0x000800: fan3
+0x001000: chassis
+0x002000: temp3 (W83782D and W83627HF only)
+0x010000: in7 (W83782D and W83627HF only)
+0x020000: in8 (W83782D and W83627HF only)
+
 If an alarm triggers, it will remain triggered until the hardware register
 is read at least once. This means that the cause for the alarm may
 already have disappeared! Note that in the current implementation, all

-- 
Jean Delvare

