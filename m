From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.65
Message-Id: <10481995631475@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10481995574110@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1143.1.2, 2003/03/18 14:36:49-08:00, greg@kroah.com

[PATCH] i2c i2c-i801.c: remove check_region() usage.


 drivers/i2c/busses/i2c-i801.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:58:00 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:58:00 2003
@@ -158,10 +158,10 @@
 		}
 	}
 
-	if (check_region(i801_smba, (isich4 ? 16 : 8))) {
+	if (!request_region(i801_smba, (isich4 ? 16 : 8), "i801-smbus")) {
 		dev_err(&dev->dev, "I801_smb region 0x%x already in use!\n",
 			i801_smba);
-		error_return = -ENODEV;
+		error_return = -EBUSY;
 		goto END;
 	}
 
@@ -180,8 +180,6 @@
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 1);
 		dev_warn(&dev->dev, "enabling SMBus device\n");
 	}
-
-	request_region(i801_smba, (isich4 ? 16 : 8), "i801-smbus");
 
 	if (temp & 0x02)
 		dev_dbg(&dev->dev, "I801 using Interrupt SMI# for SMBus.\n");
