From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 15:37:49 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627hf) Document W83627THF voltage
Message-Id: <20101129163749.790c7512@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I had to look it up for one user, so we might as well store it in the
driver documentation.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83627hf |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- linux-2.6.37-rc3.orig/Documentation/hwmon/w83627hf	2010-10-21 10:01:11.000000000 +0200
+++ linux-2.6.37-rc3/Documentation/hwmon/w83627hf	2010-11-29 16:24:34.000000000 +0100
@@ -91,3 +91,25 @@ isaset -y -f 0x2e 0xaa
 
 The above sequence assumes a Super-I/O config space at 0x2e/0x2f, but
 0x4e/0x4f is also possible.
+
+Voltage pin mapping
+-------------------
+
+Here is a summary of the voltage pin mapping for the W83627THF. This
+can be useful to convert data provided by board manufacturers into a
+value libsensors configuration.
+
+  W83627THF		|
+  Pin	| Name		| Register	| Sysfs attribute
+-----------------------------------------------------
+  100	| CPUVCORE	| 20h		| in0
+   99	| VIN0		| 21h		| in1
+   98	| VIN1		| 22h		| in2
+   97	| VIN2		| 24h		| in4
+  114	| AVCC		| 23h		| in3
+   61	| 5VSB		| 50h (bank 5)	| in7
+   74	| VBAT		| 51h (bank 5)	| in8
+
+For other supported devices, you'll have to take the hard path and
+look up the information in the datasheet yourself (and then add it
+to this document please.)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
