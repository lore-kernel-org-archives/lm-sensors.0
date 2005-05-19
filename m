From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <10728219742126@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10728219741342@kroah.com>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1496.9.5, 2003/12/04 13:53:21-08:00, khali@linux-fr.org

[PATCH] I2C: fix author of i2c-savage4.c driver

This patch rehabilitates Alexander Wold as the author of the i2c-savage4
driver. For some reason, his name was not mentioned anywhere in the
first place.

The change was requested by Alexander Wold himself.


 drivers/i2c/busses/i2c-savage4.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	Tue Dec 30 12:31:52 2003
+++ b/drivers/i2c/busses/i2c-savage4.c	Tue Dec 30 12:31:52 2003
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

