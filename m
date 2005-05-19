From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.65
Message-Id: <10481995651628@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10481995642679@kroah.com>
References: <10481995631475@kroah.com>
In-Reply-To: <10481995631475@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1143.1.5, 2003/03/18 17:10:51-08:00, greg@kroah.com

[PATCH] i2c i2c-piix4.c: remove check_region() call.


 drivers/i2c/busses/i2c-piix4.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Thu Mar 20 12:56:54 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Thu Mar 20 12:56:54 2003
@@ -149,7 +149,7 @@
 		}
 	}
 
-	if (check_region(piix4_smba, 8)) {
+	if (!request_region(piix4_smba, 8, "piix4-smbus")) {
 		printk
 		    (KERN_ERR "i2c-piix4.o: SMB region 0x%x already in use!\n",
 		     piix4_smba);
@@ -187,9 +187,6 @@
 			goto END;
 		}
 	}
-
-	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(piix4_smba, 8, "piix4-smbus");
 
 #ifdef DEBUG
 	if ((temp & 0x0E) = 8)
