From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: Kill i2c_client.id (4/5)
Message-Id: <11099685942662@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685933363@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2086, 2005/03/02 11:52:48-08:00, khali@linux-fr.org

[PATCH] I2C: Kill i2c_client.id (4/5)

> (4/5) Deprecate i2c_client.id.

Now that i2c_client.id has no more users in the kernel (none that I
could find at least) we could remove that struct member. I however think
that it's better to only deprecate it at the moment, in case I missed
users or any of the other patches are delayed for some reason. We could
then delete the id member definitely in a month or so.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/i2c.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:26:05 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:26:05 -08:00
@@ -144,7 +144,7 @@
  * function is mainly used for lookup & other admin. functions.
  */
 struct i2c_client {
-	int id;
+	__attribute__ ((deprecated)) int id;
 	unsigned int flags;		/* div., see below		*/
 	unsigned int addr;		/* chip address - NOTE: 7bit 	*/
 					/* addresses are stored in the	*/

