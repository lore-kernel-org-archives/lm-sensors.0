From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH 2.6] Discard out-of-date comment in adm1021 driver
Message-Id: <20040321184051.0fdfd76b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This simple patch discards an out-of-date comment in the adm1021 driver.
I've done the same in our CVS repository where many more drivers were
affected.

I agree it's not very important, but I prefer it to be done before any
driver with the error is used as a base to port a new driver, and the
misinformation spreads.

Please apply,
thanks.

--- linux-2.6.5-rc1/drivers/i2c/chips/adm1021.c.orig	2004-03-18 11:52:44.000000000 +0100
+++ linux-2.6.5-rc1/drivers/i2c/chips/adm1021.c	2004-03-18 14:42:50.000000000 +0100
@@ -151,9 +151,6 @@
 	.detach_client	= adm1021_detach_client,
 };
 
-/* I choose here for semi-static allocation. Complete dynamic
-   allocation could also be used; the code needed for this would probably
-   take more memory than the datastructure takes now. */
 static int adm1021_id = 0;
 
 #define show(value)	\


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
