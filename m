From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913922046@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913921004@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1597.1.8, 2004/02/23 17:23:15-08:00, greg@kroah.com

I2C: fix compiler warnings in 2 drivers.


 drivers/i2c/busses/i2c-elv.c      |    2 +-
 drivers/i2c/busses/i2c-velleman.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elv.c b/drivers/i2c/busses/i2c-elv.c
--- a/drivers/i2c/busses/i2c-elv.c	Mon Mar 15 14:35:57 2004
+++ b/drivers/i2c/busses/i2c-elv.c	Mon Mar 15 14:35:57 2004
@@ -152,7 +152,7 @@
 			return -ENODEV;
 		}
 	}
-	pr_debug("i2c-elv: found device at %#x.\n",base);
+	pr_debug("i2c-elv: found device at %p.\n", (void *)base);
 	return 0;
 }
 
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- a/drivers/i2c/busses/i2c-velleman.c	Mon Mar 15 14:35:57 2004
+++ b/drivers/i2c/busses/i2c-velleman.c	Mon Mar 15 14:35:57 2004
@@ -138,7 +138,7 @@
 			return -ENODEV;
 		}
 	}
-	pr_debug("i2c-velleman: found device at %#x.\n",base);
+	pr_debug("i2c-velleman: found device at %p.\n",(void *)base);
 	return 0;
 }
 

