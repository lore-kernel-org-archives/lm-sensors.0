From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH] I2C: Delete useless instruction in it87
Message-Id: <11123113941998@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113943693@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2344, 2005/03/31 14:31:02-08:00, khali@linux-fr.org

[PATCH] I2C: Delete useless instruction in it87

The IT8705F doesn't support VID, so it's quite pointless to give a value
to it (and an arbitrary one at that). I think that this instruction was
there for compatibility reasons some times ago, but the reasons went
away while the instruction was left in place. We can safely delete it
now.

Thanks to Rudolf Marek for testing the patch (you never know).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/it87.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-03-31 15:16:38 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-03-31 15:16:38 -08:00
@@ -1122,9 +1122,6 @@
 			    it87_read_value(client, IT87_REG_TEMP_LOW(i));
 		}
 
-		/* The 8705 does not have VID capability */
-		data->vid = 0x1f;
-
 		i = it87_read_value(client, IT87_REG_FAN_DIV);
 		data->fan_div[0] = i & 0x07;
 		data->fan_div[1] = (i >> 3) & 0x07;

