From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 28 May 2015 15:22:49 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Detect graphics card in all cases
Message-Id: <20150528172249.7a9a0957@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On recent kernels, the i2c bus may not be an immediate child of the
graphics device, instead there can be a drm class device in between.
Treat all drm class devices as graphics devices so that probing the
i2c bus is disabled by default as intended.
---
 prog/detect/sensors-detect |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2015-05-28 08:01:21.884379048 +0200
+++ lm-sensors/prog/detect/sensors-detect	2015-05-28 17:15:58.685620089 +0200
@@ -3897,7 +3897,9 @@ sub get_pci_class
 	my ($subsystem, $class);
 
 	$subsystem = sysfs_device_subsystem($device);
-	return 0 unless defined $subsystem && $subsystem eq "pci";
+	return 0 unless defined $subsystem;
+	return 0x0300 if $subsystem eq "drm";	# Graphics card
+	return 0 unless $subsystem eq "pci";
 
 	$class = sysfs_device_attribute($device, "class");
 	return 0 unless defined $class;


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
