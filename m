From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: just delete the id field, let's not delay it any longer
Message-Id: <11099685944086@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685942488@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: greg@kroah.com

ChangeSet 1.2088, 2005/03/02 11:58:47-08:00, greg@kroah.com

[PATCH] I2C: just delete the id field, let's not delay it any longer

Becides, sparse keeps complaining when it sees this attribute within a structure...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/i2c.h |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:25:51 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:25:51 -08:00
@@ -144,7 +144,6 @@
  * function is mainly used for lookup & other admin. functions.
  */
 struct i2c_client {
-	__attribute__ ((deprecated)) int id;
 	unsigned int flags;		/* div., see below		*/
 	unsigned int addr;		/* chip address - NOTE: 7bit 	*/
 					/* addresses are stored in the	*/

