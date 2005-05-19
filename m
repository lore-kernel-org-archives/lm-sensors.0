From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814513603@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814513668@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.18, 2004/04/08 14:12:39-07:00, akpm@osdl.org

[PATCH] I2C: i2c-ali1563.c section fix

ali1563_shutdown() is called from __init ali1563_probe() and hence cannot be
marked __init.


 drivers/i2c/busses/i2c-ali1563.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:27 2004
+++ b/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:27 2004
@@ -343,7 +343,7 @@
 	return -ENODEV;
 }
 
-static void __exit ali1563_shutdown(struct pci_dev * dev)
+static void ali1563_shutdown(struct pci_dev *dev)
 {
 	release_region(ali1563_smba,ALI1563_SMB_IOSIZE);
 }

