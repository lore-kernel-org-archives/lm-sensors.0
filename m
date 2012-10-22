From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2012 12:16:57 +0000
Subject: [lm-sensors] [PATCH 2/2] sensors-detect: Fix parent device discovery
Message-Id: <20121022141657.147db99d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Take multiplexers into account when looking up the parent device of
each I2C adapter. We don't bother with old kernels as they didn't have
support for multiplexers anyway.
---
 prog/detect/sensors-detect |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2012-10-06 13:21:05.000000000 +0200
+++ lm-sensors/prog/detect/sensors-detect	2012-10-06 14:39:58.981616135 +0200
@@ -2,7 +2,7 @@
 #
 #    sensors-detect - Detect hardware monitoring chips
 #    Copyright (C) 1998 - 2002  Frodo Looijaard <frodol@dds.nl>
-#    Copyright (C) 2004 - 2011  Jean Delvare <khali@linux-fr.org>
+#    Copyright (C) 2004 - 2012  Jean Delvare <khali@linux-fr.org>
 #
 #    This program is free software; you can redistribute it and/or modify
 #    it under the terms of the GNU General Public License as published by
@@ -2696,14 +2696,15 @@ sub initialize_i2c_adapters_list
 			} elsif ($link =~ m/^(.*)\/i2c-$nr$/) {
 				$entry->{path} = "${base_dir}/i2c-$nr/device";
 				$entry->{parent} = "${base_dir}/i2c-$nr/$1";
-			} else {
-				$entry->{path} = "${base_dir}/i2c-$nr";
-				$entry->{parent} = "$entry->{path}/device";
 			}
-		} else {
+		}
+
+		# This works for all recent kernels (with or without
+		# CONFIG_I2C_COMPAT)
+		if (!defined $entry->{path}) {
 			my $link = readlink("${base_dir}/i2c-$nr");
-			$link =~ s/\/i2c-$nr$//;
 			$entry->{path} = "${base_dir}/i2c-$nr";
+			$link =~ s/(\/i2c-[0-9]+)+$//;	# Handle multiplexers too
 			$entry->{parent} = "${base_dir}/$link";
 		}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
