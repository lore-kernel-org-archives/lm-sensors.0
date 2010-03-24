From: Giel van Schijndel <me@mortis.eu>
Date: Wed, 24 Mar 2010 09:09:31 +0000
Subject: [lm-sensors] [PATCH] hwmon: f71882fg: acquire I/O regions while
Message-Id: <1269421771-9775-1-git-send-email-me@mortis.eu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100324084643.GB6368@salidar.me.mortis.eu>
In-Reply-To: <20100324084643.GB6368@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Giel van Schijndel <me@mortis.eu>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Acquire the I/O region for the Super I/O chip while we're working on it.

Signed-off-by: Giel van Schijndel <me@mortis.eu>
---
 drivers/hwmon/f71882fg.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index ca34e5c..fe7b671 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2178,6 +2178,13 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 	int err = -ENODEV;
 	u16 devid;
 
+	/* Don't step on other drivers' I/O space by accident */
+	if (!request_region(sioaddr, 2, DRVNAME)) {
+		printk(KERN_ERR DRVNAME ": I/O address 0x%04x already in use\n",
+				(int)sioaddr);
+		return -EIO;
+	}
+
 	superio_enter(sioaddr);
 
 	devid = superio_inw(sioaddr, SIO_REG_MANID);
@@ -2232,6 +2239,7 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 		(int)superio_inb(sioaddr, SIO_REG_DEVREV));
 exit:
 	superio_exit(sioaddr);
+	release_region(sioaddr, 2);
 	return err;
 }
 
-- 
1.6.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
