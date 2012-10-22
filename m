From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2012 12:15:24 +0000
Subject: [lm-sensors] [PATCH 1/2] sensors-detect: Skip graphics cards by default
Message-Id: <20121022141524.1778b4e2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't probe I2C buses on graphics cards by default. Their drivers will
typically instantiate the I2C slave devices themselves as needed, and
such probes have been occasionally reported to cause serious trouble.
---
 prog/detect/sensors-detect |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2012-08-27 13:18:01.000000000 +0200
+++ lm-sensors/prog/detect/sensors-detect	2012-10-06 13:21:05.277537273 +0200
@@ -3652,8 +3652,8 @@ sub scan_i2c_adapter
 	my ($funcs, $chip, $addr, $class, $default, $input, @not_to_scan);
 
 	$class = get_pci_class($i2c_adapters[$adapter_nr]->{parent});
-	if (($class & 0xff00) = 0x0400) {
-		# Do not probe adapters on PCI multimedia cards by default
+	# Do not probe adapters on multimedia and graphics cards by default
+	if (($class & 0xff00) = 0x0400 || ($class & 0xff00) = 0x0300) {
 		$default = 0;
 	} elsif ($class = 0x0c01 || $class = 0x0c05
 	      || find_i2c_adapter_driver($i2c_adapters[$adapter_nr]->{name})) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
