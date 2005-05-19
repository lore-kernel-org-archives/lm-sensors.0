From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814492936@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1081981449280@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.3, 2004/03/25 10:50:47-08:00, khali@linux-fr.org

[PATCH] I2C: Discard out-of-date comment in adm1021 driver

This simple patch discards an out-of-date comment in the adm1021 driver.
I've done the same in our CVS repository where many more drivers were
affected.

I agree it's not very important, but I prefer it to be done before any
driver with the error is used as a base to port a new driver, and the
misinformation spreads.


 drivers/i2c/chips/adm1021.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:14:49 2004
+++ b/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:14:49 2004
@@ -151,9 +151,6 @@
 	.detach_client	= adm1021_detach_client,
 };
 
-/* I choose here for semi-static allocation. Complete dynamic
-   allocation could also be used; the code needed for this would probably
-   take more memory than the datastructure takes now. */
 static int adm1021_id = 0;
 
 #define show(value)	\

