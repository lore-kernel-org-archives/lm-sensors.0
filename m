From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Discard pointless comment in via686a
Message-Id: <20040330204200.1abc5f97.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The simple patch below discards a comment in via686a referencing a file
that doesn't belong to the Linux tree. Now that I tell people not to do
that in my porting guide, we better follow our own advice.

Please apply,
thanks.

--- linux-2.6.5-rc2/drivers/i2c/chips/via686a.c.orig	Mon Mar 29 20:46:02 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/via686a.c	Tue Mar 30 20:26:13 2004
@@ -27,7 +27,6 @@
 /*
     Supports the Via VT82C686A, VT82C686B south bridges.
     Reports all as a 686A.
-    See doc/chips/via686a for details.
     Warning - only supports a single device.
 */
 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
