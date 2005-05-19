From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH 2.6] I2C: Delete useless instruction in it87
Message-Id: <20050324222458.658f4660.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The IT8705F doesn't support VID, so it's quite pointless to give a value
to it (and an arbitrary one at that). I think that this instruction was
there for compatibility reasons some times ago, but the reasons went
away while the instruction was left in place. We can safely delete it
now.

Thanks to Rudolf Marek for testing the patch (you never know).

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-mm1/drivers/i2c/chips/it87.c.orig	Wed Mar 23 16:21:25 2005
+++ linux-2.6.12-rc1-mm1/drivers/i2c/chips/it87.c	Thu Mar 24 14:06:35 2005
@@ -1122,9 +1122,6 @@
 			    it87_read_value(client, IT87_REG_TEMP_LOW(i));
 		}
 
-		/* The 8705 does not have VID capability */
-		data->vid = 0x1f;
-
 		i = it87_read_value(client, IT87_REG_FAN_DIV);
 		data->fan_div[0] = i & 0x07;
 		data->fan_div[1] = (i >> 3) & 0x07;


-- 
Jean Delvare
