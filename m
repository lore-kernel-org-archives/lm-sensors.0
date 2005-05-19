From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [04/08] I2C: Fix oops in eeprom driver
Message-Id: <20050405164711.GE17299@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050405164539.GA17299@kroah.com>
In-Reply-To: <20050405164539.GA17299@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: khali@linux-fr.org, sensors@stimpy.netroedge.com

-stable review patch.  If anyone has any objections, please let us know.

------------------

This fixes an oops in the eeprom driver. It was first reported here:
  http://bugzilla.kernel.org/show_bug.cgi?idC47

It was additionally discussed here (while tracking a completely
different bug):
  http://archives.andrew.net.au/lm-sensors/msg30021.html

The patch is already in 2.6.12-rc1:
  http://linux.bkbits.net:8080/linux-2.5/cset@1.2227

The oops happens when one reads data from the sysfs interface file such
that (off < 16) and (count < 16 - off). For example "sensors" from
lm_sensors 2.9.0 does this, and causes the oops.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.11.4/drivers/i2c/chips/eeprom.c.orig	2005-03-13 10:00:01.000000000 +0100
+++ linux-2.6.11.4/drivers/i2c/chips/eeprom.c	2005-03-17 19:54:07.000000000 +0100
@@ -130,7 +130,8 @@
 
 	/* Hide Vaio security settings to regular users (16 first bytes) */
 	if (data->nature = VAIO && off < 16 && !capable(CAP_SYS_ADMIN)) {
-		int in_row1 = 16 - off;
+		size_t in_row1 = 16 - off;
+		in_row1 = min(in_row1, count);
 		memset(buf, 0, in_row1);
 		if (count - in_row1 > 0)
 			memcpy(buf + in_row1, &data->data[16], count - in_row1);

