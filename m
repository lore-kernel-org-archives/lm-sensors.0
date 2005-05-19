From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <10728219711046@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10728219713483@kroah.com>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1496.8.38, 2003/12/30 12:10:08-08:00, khali@linux-fr.org

[PATCH] I2C: Fix SCx200 dependancies

The following patch fixes incorrect dependencies (as far as I can see)
for the SCx200 modules. A similar patch (with even more fixes) is also
needed for Linux 2.4, and will be part of my next wave to Marcelo. Note
that I don't have the necessary hardware to actually test anything, but
a quick look at the code doesn't leave much place for doubt IMHO.


 drivers/i2c/busses/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Tue Dec 30 12:28:44 2003
+++ b/drivers/i2c/busses/Kconfig	Tue Dec 30 12:28:44 2003
@@ -202,7 +202,7 @@
 
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
-	depends on SCx200 && I2C_ALGOBIT
+	depends on SCx200_GPIO && I2C_ALGOBIT
 	help
 	  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
 
@@ -229,7 +229,7 @@
 
 config SCx200_ACB
 	tristate "NatSemi SCx200 ACCESS.bus"
-	depends on I2C_ALGOBIT!=n && I2C
+	depends on I2C
 	help
 	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
 

