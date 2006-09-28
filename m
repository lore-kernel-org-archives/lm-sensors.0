From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:43 +0000
Subject: [lm-sensors] [PATCH 23/39] vt1211: Document module parameters
Message-Id: <11594838192090-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Juerg Haefliger <juergh at gmail.com>

vt1211: Document module parameters

Add a description of the module parameters to the documentation of
the vt1211 driver.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/hwmon/vt1211 |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/vt1211 b/Documentation/hwmon/vt1211
index d6d8071..77fa633 100644
--- a/Documentation/hwmon/vt1211
+++ b/Documentation/hwmon/vt1211
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
-- 
1.4.2.1


