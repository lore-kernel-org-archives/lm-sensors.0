From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <10559607091816@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10559607092693@kroah.com>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1318.3.8, 2003/06/17 15:37:40-07:00, greg@kroah.com

I2C: fix resource leak in i2c-ali15x3.c


 drivers/i2c/busses/i2c-ali15x3.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Wed Jun 18 11:19:16 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Wed Jun 18 11:19:16 2003
@@ -177,17 +177,18 @@
 	if(force_addr) {
 		dev_info(&ALI15X3_dev->dev, "forcing ISA address 0x%04X\n",
 			ali15x3_smba);
-		if (PCIBIOS_SUCCESSFUL !-		    pci_write_config_word(ALI15X3_dev, SMBBA, ali15x3_smba))
-			return -ENODEV;
-		if (PCIBIOS_SUCCESSFUL !-		    pci_read_config_word(ALI15X3_dev, SMBBA, &a))
-			return -ENODEV;
+		if (PCIBIOS_SUCCESSFUL != pci_write_config_word(ALI15X3_dev,
+								SMBBA,
+								ali15x3_smba))
+			goto error;
+		if (PCIBIOS_SUCCESSFUL != pci_read_config_word(ALI15X3_dev,
+								SMBBA, &a))
+			goto error;
 		if ((a & ~(ALI15X3_SMB_IOSIZE - 1)) != ali15x3_smba) {
 			/* make sure it works */
 			dev_err(&ALI15X3_dev->dev,
 				"force address failed - not supported?\n");
-			return -ENODEV;
+			goto error;
 		}
 	}
 	/* check if whole device is enabled */
@@ -219,6 +220,9 @@
 	dev_dbg(&ALI15X3_dev->dev, "iALI15X3_smba = 0x%X\n", ali15x3_smba);
 
 	return 0;
+error:
+	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
+	return -ENODEV;
 }
 
 /* Internally used pause function */

