From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:22 +0000
Subject: [lm-sensors] [PATCH 2/39] hwmon: Documentation update for w83627ehf
Message-Id: <11594837444099-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at sh.cvut.cz>

Add documentation for the w83627ehf hardware monitoring driver.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/hwmon/w83627ehf |   85 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/w83627ehf b/Documentation/hwmon/w83627ehf
new file mode 100644
index 0000000..1474e78
--- /dev/null
+++ b/Documentation/hwmon/w83627ehf
@@ -0,0 +1,85 @@
+Kernel driver w83627ehf
+===========+
+Supported chips:
+  * Winbond W83627EHF/EHG (ISA access ONLY)
+    Prefix: 'w83627ehf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83627EHF_%20W83627EHGb.pdf
+
+Authors:
+        Jean Delvare <khali at linux-fr.org>
+        Yuan Mu <Ymu at Winbond.com.tw>
+        Rudolf Marek <r.marek at sh.cvut.cz>
+
+Description
+-----------
+
+This driver implements support for the Winbond W83627EHF and W83627EHG
+super I/O chips. We will refer to them collectively as Winbond chips.
+
+The chips implement three temperature sensors, five fan rotation
+speed sensors, ten analog voltage sensors, alarms with beep warnings (control
+unimplemented), and some automatic fan regulation strategies (plus manual
+fan control mode).
+
+Temperatures are measured in degrees Celsius and measurement resolution is 1
+degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
+the temperature gets higher than high limit; it stays on until the temperature
+falls below the Hysteresis value.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4, 8, 16, 32, 64 or
+128) to give the readings more range or accuracy. The driver sets the most
+suitable fan divisor itself. Some fans might not be present because they
+share pins with other functions.
+
+Voltage sensors (also known as IN sensors) report their values in millivolts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit.
+
+The driver supports automatic fan control mode known as Thermal Cruise.
+In this mode, the chip attempts to keep the measured temperature in a
+predefined temperature range. If the temperature goes out of range, fan
+is driven slower/faster to reach the predefined range again.
+
+The mode works for fan1-fan4. Mapping of temperatures to pwm outputs is as
+follows:
+
+temp1 -> pwm1
+temp2 -> pwm2
+temp3 -> pwm3
+prog  -> pwm4 (the programmable setting is not supported by the driver)
+
+/sys files
+----------
+
+pwm[1-4] - this file stores PWM duty cycle or DC value (fan speed) in range:
+	   0 (stop) to 255 (full)
+
+pwm[1-4]_enable - this file controls mode of fan/temperature control:
+	* 1 Manual Mode, write to pwm file any value 0-255 (full speed)
+	* 2 Thermal Cruise
+
+Thermal Cruise mode
+-------------------
+
+If the temperature is in the range defined by:
+
+pwm[1-4]_target    - set target temperature, unit millidegree Celcius
+		     (range 0 - 127000)
+pwm[1-4]_tolerance - tolerance, unit millidegree Celcius (range 0 - 15000)
+
+there are no changes to fan speed. Once the temperature leaves the interval,
+fan speed increases (temp is higher) or decreases if lower than desired.
+There are defined steps and times, but not exported by the driver yet.
+
+pwm[1-4]_min_output - minimum fan speed (range 1 - 255), when the temperature
+                      is below defined range.
+pwm[1-4]_stop_time  - how many milliseconds [ms] must elapse to switch
+                      corresponding fan off. (when the temperature was below
+                      defined range).
+
+Note: last two functions are influenced by other control bits, not yet exported
+      by the driver, so a change might not have any effect.
-- 
1.4.2.1


