From: =?ISO-8859-1?Q?Per_Dal=E9n?= <per.dalen@appeartv.com>
Date: Thu, 26 May 2011 09:27:27 +0000
Subject: [lm-sensors] [PATCH v2] sensors-detect: Add detection of MAX6642
Message-Id: <4DDE1CFF.1020906@appeartv.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Changed according to the suggestions from Guenter Roeck:

* Check the manufacturer ID directly. Fastens the test if it's not a
Maxim chip.
* Read the other non-existing registers after the manufacturer ID.

---

This patch adds detection of MAX6642 to sensors-detect.

Signed-off-by: Per Dalen <per.dalen@appeartv.com>
---

--- prog/detect/sensors-detect	(revision 5975)
+++ prog/detect/sensors-detect	(working copy)
@@ -848,6 +848,11 @@
 		i2c_addrs => [0x2c, 0x2e, 0x2f],
 		i2c_detect => sub { max6639_detect(@_); },
 	}, {
+		name => "Maxim MAX6642",
+		driver => "max6642",
+		i2c_addrs => [0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f],
+		i2c_detect => sub { max6642_detect(@_); },
+	}, {
 		name => "Maxim MAX6655/MAX6656",
 		driver => "max6655",
 		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
@@ -5779,6 +5784,36 @@
 	return 6;
 }

+# Chip to detect: MAX6642
+# Registers used:
+#   0x02: Status register
+#   0x03: Configuration register
+#   0xfe: Manufacturer ID
+#   0x04,0x06,0xff: No registers
+# We use the 0x04,0x06 and 0xff addresses (unused) to improve the
reliability.
+# These are not real registers and will always return the last returned
value.
+# This isn't documented.
+sub max6642_detect
+{
+	my ($file, $addr) = @_;
+	my ($man_id, $conf, $status);
+
+	$man_id = i2c_smbus_read_byte_data($file, 0xfe, NO_CACHE);
+	return unless $man_id = 0x4d;	# Maxim
+	return if i2c_smbus_read_byte_data($file, 0x04, NO_CACHE) != $man_id;
+	return if i2c_smbus_read_byte_data($file, 0x06, NO_CACHE) != $man_id;
+	return if i2c_smbus_read_byte_data($file, 0xff, NO_CACHE) != $man_id;
+	$status = i2c_smbus_read_byte_data($file, 0x02, NO_CACHE);
+	$conf = i2c_smbus_read_byte_data($file, 0x03, NO_CACHE);
+
+	# Bit 5, 3, 1 and 0 should be zero
+	return unless ($status & 0x2b) = 0x00;
+	# The 4 lower bits should be zero
+	return unless ($conf & 0x0f) = 0x00;
+
+	return 6;
+}
+
 sub max6655_detect
 {
 	my ($file, $addr) = @_;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
