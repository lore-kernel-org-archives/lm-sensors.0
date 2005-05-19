From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <20041119220048.GE15956@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041119215935.GA15956@kroah.com> <20041119220001.GB15956@kroah.com> <20041119220015.GC15956@kroah.com> <20041119220030.GD15956@kroah.com>
In-Reply-To: <20041119220030.GD15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

ChangeSet 1.2167, 2004/11/19 09:14:15-08:00, paubert@iram.es

[PATCH] I2C: minor comment fix

It seems so. BTW I hate wrong comments and happened to add one
in my patch. To fix my blunder, can you apply the appended one
line removal on top of Jean's patch.


Signed-off-by: Gabriel Paubert <paubert@iram.es>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-19 11:40:37 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-19 11:40:37 -08:00
@@ -1021,7 +1021,6 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
-/* Returns the number of bytes transferred */
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
 			       u8 length, u8 *values)
 {
