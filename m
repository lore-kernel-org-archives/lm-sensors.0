From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add f71805f documentation
Message-Id: <1139257137403@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Add f71805f documentation

Add some documentation for the new f71805f driver. This is almost the
same help that was present in lm_sensors, with a few minor layout fixes.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 5db3d3da93fb93875c719239892ac526cfd2d584
tree 07af0954704006b2c0e77fe2840c3432bc34a971
parent 7e3d7db52469f6bcfbfd2d3d00dd17da573facd9
author Jean Delvare <khali at linux-fr.org> Mon, 09 Jan 2006 23:32:57 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:15 -0800

 Documentation/hwmon/f71805f |  105 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/f71805f b/Documentation/hwmon/f71805f
new file mode 100644
index 0000000..28c5b7d
--- /dev/null
+++ b/Documentation/hwmon/f71805f
@@ -0,0 +1,105 @@
+Kernel driver f71805f
+==========+
+Supported chips:
+  * Fintek F71805F/FG
+    Prefix: 'f71805f'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Provided by Fintek on request
+
+Author: Jean Delvare <khali at linux-fr.org>
+
+Thanks to Denis Kieft from Barracuda Networks for the donation of a
+test system (custom Jetway K8M8MS motherboard, with CPU and RAM) and
+for providing initial documentation.
+
+Thanks to Kris Chen from Fintek for answering technical questions and
+providing additional documentation.
+
+Thanks to Chris Lin from Jetway for providing wiring schematics and
+anwsering technical questions.
+
+
+Description
+-----------
+
+The Fintek F71805F/FG Super I/O chip includes complete hardware monitoring
+capabilities. It can monitor up to 9 voltages (counting its own power
+source), 3 fans and 3 temperature sensors.
+
+This chip also has fan controlling features, using either DC or PWM, in
+three different modes (one manual, two automatic). The driver doesn't
+support these features yet.
+
+The driver assumes that no more than one chip is present, which seems
+reasonable.
+
+
+Voltage Monitoring
+------------------
+
+Voltages are sampled by an 8-bit ADC with a LSB of 8 mV. The supported
+range is thus from 0 to 2.040 V. Voltage values outside of this range
+need external resistors. An exception is in0, which is used to monitor
+the chip's own power source (+3.3V), and is divided internally by a
+factor 2.
+
+The two LSB of the voltage limit registers are not used (always 0), so
+you can only set the limits in steps of 32 mV (before scaling).
+
+The wirings and resistor values suggested by Fintek are as follow:
+
+        pin                                           expected
+        name    use           R1      R2     divider  raw val.
+
+in0     VCC     VCC3.3V     int.    int.        2.00    1.65 V
+in1     VIN1    VTT1.2V      10K       -        1.00    1.20 V
+in2     VIN2    VRAM        100K    100K        2.00   ~1.25 V (1)
+in3     VIN3    VCHIPSET     47K    100K        1.47    2.24 V (2)
+in4     VIN4    VCC5V       200K     47K        5.25    0.95 V
+in5     VIN5    +12V        200K     20K       11.00    1.05 V
+in6     VIN6    VCC1.5V      10K       -        1.00    1.50 V
+in7     VIN7    VCORE        10K       -        1.00   ~1.40 V (1)
+in8     VIN8    VSB5V       200K     47K        1.00    0.95 V
+
+(1) Depends on your hardware setup.
+(2) Obviously not correct, swapping R1 and R2 would make more sense.
+
+These values can be used as hints at best, as motherboard manufacturers
+are free to use a completely different setup. As a matter of fact, the
+Jetway K8M8MS uses a significantly different setup. You will have to
+find out documentation about your own motherboard, and edit sensors.conf
+accordingly.
+
+Each voltage measured has associated low and high limits, each of which
+triggers an alarm when crossed.
+
+
+Fan Monitoring
+--------------
+
+Fan rotation speeds are reported as 12-bit values from a gated clock
+signal. Speeds down to 366 RPM can be measured. There is no theoretical
+high limit, but values over 6000 RPM seem to cause problem. The effective
+resolution is much lower than you would expect, the step between different
+register values being 10 rather than 1.
+
+The chip assumes 2 pulse-per-revolution fans.
+
+An alarm is triggered if the rotation speed drops below a programmable
+limit or is too low to be measured.
+
+
+Temperature Monitoring
+----------------------
+
+Temperatures are reported in degrees Celsius. Each temperature measured
+has a high limit, those crossing triggers an alarm. There is an associated
+hysteresis value, below which the temperature has to drop before the
+alarm is cleared.
+
+All temperature channels are external, there is no embedded temperature
+sensor. Each channel can be used for connecting either a thermal diode
+or a thermistor. The driver reports the currently selected mode, but
+doesn't allow changing it. In theory, the BIOS should have configured
+everything properly.


