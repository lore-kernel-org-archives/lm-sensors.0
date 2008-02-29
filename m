From: "Craig Kelley" <namonai@gmail.com>
Date: Fri, 29 Feb 2008 17:24:44 +0000
Subject: [lm-sensors] [patch 1/1] hwmon: add 0x8c id for smsc47b397 driver
Message-Id: <847993120802290924m6b12567p964a17e080030889@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mhoffman@lightlink.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

From: Craig Kelley <namonai@gmail.com>

Added a new ID (0x8c) for the smsc47b397 hardware monitor driver.
This ID is used by HP in, at least, their dc7700 line.

Signed-off-by: Craig Kelley <namonai@gmail.com>
---

--- drivers/hwmon/smsc47b397.c-orig     2008-02-29 07:54:18.000000000 -0800
+++ drivers/hwmon/smsc47b397.c  2008-02-29 07:53:00.000000000 -0800
@@ -331,11 +331,23 @@ exit:
 static int __init smsc47b397_find(unsigned short *addr)
 {
        u8 id, rev;
+       char *name;

        superio_enter();
        id = superio_inb(SUPERIO_REG_DEVID);

-       if ((id != 0x6f) && (id != 0x81) && (id != 0x85)) {
+       switch(id) {
+       case 0x81:
+               name = "SCH5307-NS";
+               break;
+       case 0x6f:
+               name = "LPC47B397-NC";
+               break;
+       case 0x85:
+       case 0x8c:
+               name = "SCH5317";
+               break;
+       default:
                superio_exit();
                return -ENODEV;
        }
@@ -348,8 +360,7 @@ static int __init smsc47b397_find(unsign

        printk(KERN_INFO DRVNAME ": found SMSC %s "
                "(base address 0x%04x, revision %u)\n",
-               id = 0x81 ? "SCH5307-NS" : id = 0x85 ? "SCH5317" :
-              "LPC47B397-NC", *addr, rev);
+               name, *addr, rev);

        superio_exit();
        return 0;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
