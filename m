From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test3
Message-Id: <1060972406359@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1060972405413@kroah.com>
References: <1060972405413@kroah.com>
In-Reply-To: <1060972405413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1123.18.3, 2003/08/11 14:36:57-07:00, greg@kroah.com

[PATCH] i2c: fix up "raw" printk() call.


 drivers/i2c/busses/i2c-piix4.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri Aug 15 11:27:05 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri Aug 15 11:27:05 2003
@@ -164,7 +164,7 @@
 	/* Some BIOS will set up the chipset incorrectly and leave a register
 	   in an undefined state (causing I2C to act very strangely). */
 	if (temp & 0x02) {
-		printk("Fixed I2C problem on Force CPCI735\n");
+		dev_info(&PIIX4_dev->dev, "Fixed I2C problem on Force CPCI735\n");
 		temp = temp & 0xfd;
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
 	}

