From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: [PATCH 2.6] i2c bus drivers (1/4)
Message-Id: <20031129210120.52c33706.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch rehabilitates Alexander Wold as the author of the i2c-savage4
driver. For some reason, his name was not mentioned anywhere in the
first place.

The change was requested by Alexander Wold himself.

This isn't a bug fix and can be delayed until after 2.6.0 if you want.

--- linux-2.6.0-test11/drivers/i2c/busses/i2c-savage4.c.orig	Sat Oct 25 20:43:36 2003
+++ linux-2.6.0-test11/drivers/i2c/busses/i2c-savage4.c	Fri Nov 28 20:40:24 2003
@@ -1,13 +1,11 @@
 /*
     i2c-savage4.c - Part of lm_sensors, Linux kernel modules for hardware
               monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>,
-    Ralph Metzler <rjkm@thp.uni-koeln.de>, and
+    Copyright (C) 1998-2003  The LM Sensors Team
+    Alexander Wold <awold@bigfoot.com>
     Mark D. Studebaker <mdsxyz123@yahoo.com>
     
-    Based on code written by Ralph Metzler <rjkm@thp.uni-koeln.de> and
-    Simon Vogl
+    Based on i2c-voodoo3.c.
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -195,9 +193,7 @@
 	pci_unregister_driver(&savage4_driver);
 }
 
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
-		"Philip Edelbrock <phil@netroedge.com>, "
-		"Ralph Metzler <rjkm@thp.uni-koeln.de>, "
+MODULE_AUTHOR("Alexander Wold <awold@bigfoot.com> "
 		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("Savage4 I2C/SMBus driver");
 MODULE_LICENSE("GPL");

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
