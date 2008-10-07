From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 07 Oct 2008 01:18:49 +0000
Subject: [lm-sensors] [PATCH 05/12] adt7470: Add documentation
Message-Id: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-scsi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


Add at least the bare minimum of documentation for this chip.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 Documentation/hwmon/adt7470 |   74 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/adt7470 b/Documentation/hwmon/adt7470
new file mode 100644
index 0000000..10f398b
--- /dev/null
+++ b/Documentation/hwmon/adt7470
@@ -0,0 +1,74 @@
+Kernel driver adt7470
+===========
+
+Supported chips:
+  * Analog Devices ADT7470
+    Prefix: 'adt7470'
+    Addresses scanned: I2C 0x2C, 0x2E, 0x2F
+    Datasheet: Publicly available at the Analog Devices website
+
+Author: Darrick J. Wong
+
+Description
+-----------
+
+This driver implements support for the Analog Devices ADT7470 chip family.
+
+The ADT7470 uses the 2-wire interface compatible with the SMBUS 2.0
+specification. Using an analog to digital converter it measures ten (10)
+temperatures. It has four (4) 16-bit counters for measuring fan speed. There
+are four (4) PWM outputs that can be used to control fan speed.
+
+A sophisticated control system for the PWM outputs is designed into the ADT7470
+that allows fan speed to be adjusted automatically based on any of the three
+temperature sensors. Each PWM output is individually adjustable and
+programmable. Once configured, the ADT7470 will adjust the PWM outputs in
+response to the measured temperatures without further host intervention.  This
+feature can also be disabled for manual control of the PWM's.
+
+Each of the measured inputs (temperature, fan speed) has corresponding high/low
+limit values. The ADT7470 will signal an ALARM if any measured value exceeds
+either limit.
+
+The ADT7470 DOES NOT sample all inputs continuously.  A single pin on the
+ADT7470 is connected to a multitude of thermal diodes, but the chip must be
+instructed explicitly to read the multitude of diodes.  If you want to use
+automatic fan control mode, you must manually read any of the temperature
+sensors or the fan control algorithm will not run.  The chip WILL NOT DO THIS
+AUTOMATICALLY; this must be done from userspace.  This may be a bug in the chip
+design, given that many other AD chips take care of this.  The driver will not
+read the registers more often than once every other second.  Further,
+configuration data is only read once per minute.
+
+Special Features
+----------------
+
+The ADT7470 have a 8-bit ADC and can therefore measure temperatures
+with 1 degC resolution.
+
+The Analog Devices datasheet is very detailed and describes a procedure for
+determining an optimal configuration for the automatic PWM control.
+
+Configuration Notes
+-------------------
+
+Besides standard interfaces driver adds the following:
+
+* PWM Control
+
+* pwm#_auto_point1_pwm and temp#_auto_point1_temp and
+* pwm#_auto_point2_pwm and temp#_auto_point2_temp -
+
+point1: Set the pwm speed at a lower temperature bound.
+point2: Set the pwm speed at a higher temperature bound.
+
+The ADT7470 will scale the pwm between the lower and higher pwm speed when
+the temperature is between the two temperature boundaries.  PWM values range
+from 0 (off) to 255 (full speed).  Fan speed will be set to maximum when the
+temperature sensor associated with the PWM control exceeds temp#_max.
+
+Notes
+-----
+
+As stated above, the temperature inputs must be read periodically from
+userspace in order for the automatic pwm algorithm to run.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
