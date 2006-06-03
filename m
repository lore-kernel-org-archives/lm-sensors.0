From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 03 Jun 2006 09:26:59 +0000
Subject: [lm-sensors] [PATCH] libsensors error reports
Message-Id: <20060603112659.f707691c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

It seems that libsensors is reporting errors in cases where there are no
errors, but simply no sensors were found. This was reported by several
confused users in the past few months. I think we should fix this.
Proposed patch below, comments welcome. Mark, is this OK with you?

Index: lib/sysfs.c
=================================--- lib/sysfs.c	(revision 4036)
+++ lib/sysfs.c	(working copy)
@@ -112,7 +112,8 @@
 	}
 
 	if (!(devs = sysfs_get_bus_devices(bus))) {
-		ret = -SENSORS_ERR_PROC;
+		if (errno)
+			ret = -SENSORS_ERR_PROC;
 		goto exit1;
 	}
 
@@ -142,7 +143,8 @@
 	}
 
 	if (!(clsdevs = sysfs_get_class_devices(cls))) {
-		ret = -SENSORS_ERR_PROC;
+		if (errno)
+			ret = -SENSORS_ERR_PROC;
 		goto exit;
 	}
 

-- 
Jean Delvare

