From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test3
Message-Id: <10609724051936@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030815183207.GA3851@kroah.com>
References: <1060972405413@kroah.com>
In-Reply-To: <1060972405413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1123.18.1, 2003/08/11 14:36:10-07:00, trini@kernel.crashing.org

[PATCH] I2C: Fix for i2c-piix4 with on some boards

Hello all.  On some boards with an Intel PIIX4 the BIOS (such as the one
found on a Force CPCI-735) will incorrectly configure the chipset, and
leaves a register in an undefined state causing i2c to behave strangley.
The following patches (first vs lm_sensors-2.8.0 and then vs
2.6.0-test3)  fixes the issue.


 drivers/i2c/busses/i2c-piix4.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri Aug 15 11:27:13 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri Aug 15 11:27:13 2003
@@ -160,6 +160,15 @@
 	}
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
+
+	/* Some BIOS will set up the chipset incorrectly and leave a register
+	   in an undefined state (causing I2C to act very strangely). */
+	if (temp & 0x02) {
+		printk("Fixed I2C problem on Force CPCI735\n");
+		temp = temp & 0xfd;
+		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+	}
+ 
 	/* If force_addr is set, we program the new address here. Just to make
 	   sure, we disable the PIIX4 first. */
 	if (force_addr) {

