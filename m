From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Feb 2015 21:38:14 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Nuvoton chip updates
Message-Id: <1425073094-2084-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404094141-28146-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404094141-28146-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Document driver support for NCT7802Y.
Add detection of NCT7904D.

Cc: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |  2 ++
 prog/detect/sensors-detect | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/CHANGES b/CHANGES
index 9237506..5db9fa1 100644
--- a/CHANGES
+++ b/CHANGES
@@ -32,6 +32,8 @@ SVN HEAD
                   Add detection of Intel 5500/5520/X58
                   Loosen detection rules for TS3000/TSE2002
                   Add detection of TSE2004 and TS3001
+                  Document driver support for NCT7802Y
+                  Add detection of NCT7904D
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 8fb1ae3..436cf95 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -734,10 +734,15 @@ use vars qw(@i2c_adapter_names);
 		i2c_detect => sub { w83795_detect(@_); },
 	}, {
 		name => "Nuvoton NCT7802Y",
-		driver => "to-be-written",
+		driver => "nct7802",
 		i2c_addrs => [0x28..0x2f],
 		i2c_detect => sub { nct7802_detect(@_); },
 	}, {
+		name => "Nuvoton NCT7904D",
+		driver => "nct7904",
+		i2c_addrs => [0x2d..0x2e],
+		i2c_detect => sub { nct7904_detect(@_); },
+	}, {
 		name => "Winbond W83627HF",
 		driver => "use-isa-instead",
 		i2c_addrs => [0x28..0x2f],
@@ -5635,6 +5640,32 @@ sub nct7802_detect
 }
 
 # Registers used:
+#   0x7a: Vendor ID
+#   0x7b: Chip ID
+#   0x7c: Device ID
+#   0xff: Bank Select
+#
+sub nct7904_detect
+{
+	my ($reg);
+	my ($file, $addr) = @_;
+
+	$reg = i2c_smbus_read_byte_data($file, 0x7a);
+	return unless $reg = 0x50;
+
+	$reg = i2c_smbus_read_byte_data($file, 0x7b);
+	return unless $reg = 0xc5;
+
+	$reg = i2c_smbus_read_byte_data($file, 0x7c);
+	return unless ($reg & 0xf0) = 0x50;
+
+	$reg = i2c_smbus_read_byte_data($file, 0xff);
+	return unless ($reg & 0xf8) = 0x00;
+
+	return 8;
+}
+
+# Registers used:
 #   0x48: Full I2C Address
 #   0x4e: Vendor ID byte selection
 #   0x4f: Vendor ID
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
