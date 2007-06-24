From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 09:17:09 +0000
Subject: [lm-sensors] [PATCH 04/10] hwmon/w83627ehf: Add error messages for
Message-Id: <20070624111709.6881542a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: David Hubbard <david.c.hubbard@gmail.com>

If the Super-I/O device is disabled, it is likely the BIOS has a good
reason for leaving it disabled, so give a warning when enabling it --
it's not likely to be wired correctly or be able to give good data.

Also, if the Super-I/O device is configured with an address of 0, the
driver refuses to initialize it.

Signed-off-by: David Hubbard <david.c.hubbard@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.22-rc5.orig/drivers/hwmon/w83627ehf.c	2007-06-24 10:03:39.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/w83627ehf.c	2007-06-24 10:06:44.000000000 +0200
@@ -1387,14 +1387,19 @@ static int __init w83627ehf_find(int sio
 	    | superio_inb(sioaddr, SIO_REG_ADDR + 1);
 	*addr = val & IOREGION_ALIGNMENT;
 	if (*addr = 0) {
+		printk(KERN_ERR DRVNAME ": Refusing to enable a Super-I/O "
+		       "device with a base I/O port 0.\n");
 		superio_exit(sioaddr);
 		return -ENODEV;
 	}
 
 	/* Activate logical device if needed */
 	val = superio_inb(sioaddr, SIO_REG_ENABLE);
-	if (!(val & 0x01))
+	if (!(val & 0x01)) {
+		printk(KERN_WARNING DRVNAME ": Forcibly enabling Super-I/O. "
+		       "Sensor is probably unusable.\n");
 		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
+	}
 
 	superio_exit(sioaddr);
 	pr_info(DRVNAME ": Found %s chip at %#x\n", sio_name, *addr);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
