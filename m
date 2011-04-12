From: Nat Gurumoorthy <natg@google.com>
Date: Tue, 12 Apr 2011 20:50:18 +0000
Subject: [lm-sensors] [PATCH v5 2/2] Use "request_muxed_region" in it87
Message-Id: <1302641418-30304-1-git-send-email-natg@google.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
In-Reply-To: <1302641290-30212-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>
Cc: Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, Nat Gurumoorthy <natg@google.com>

02 - Chages to hwmon it87 driver to use "request_muxed_region"
Serialize access to the hardware by using "request_muxed_region" macro defined
by Alan Cox. Call to this macro will hold off the requestor if the resource is
currently busy.

Signed-off-by: Nat Gurumoorthy <natg@google.com>
---

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 316b648..3945569 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -111,6 +111,11 @@ superio_select(int ldn)
 static inline void
 superio_enter(void)
 {
+	/*
+	 * Reserve REG and REG + 1 for exclusive access.
+	 */
+	(void) request_muxed_region(REG, 2, DRVNAME);
+
 	outb(0x87, REG);
 	outb(0x01, REG);
 	outb(0x55, REG);
@@ -122,6 +127,7 @@ superio_exit(void)
 {
 	outb(0x02, REG);
 	outb(0x02, VAL);
+	release_region(REG, 2);
 }
 
 /* Logical device 4 registers */
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
