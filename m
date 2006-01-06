From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:34 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.flags, 1 of 3
Message-Id: <11365852543794@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.flags, 1 of 3

The I2C_DF_DUMMY flag is gone since 2.5.70, it's about time to
drop all ifdef'd out references thereto.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit ff179c8cf5caa17bf3d407edbb5872aa2eee6900
tree ac10dc7a3c5be7f8cd1d88736cf508600c19b8d7
parent 1de9e371b89e1cf4da123f0d92efa8eb134ca5e8
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 20:24:59 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:21 -0800

 drivers/media/video/tvmixer.c |    4 ----
 include/linux/i2c.h           |    5 -----
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
index 8318bd1..5897e5d 100644
--- a/drivers/media/video/tvmixer.c
+++ b/drivers/media/video/tvmixer.c
@@ -232,12 +232,8 @@ static struct i2c_driver driver = {
 #endif
 	.name            = "tv card mixer driver",
 	.id              = I2C_DRIVERID_TVMIXER,
-#ifdef I2C_DF_DUMMY
-	.flags           = I2C_DF_DUMMY,
-#else
 	.flags           = I2C_DF_NOTIFY,
 	.detach_adapter  = tvmixer_adapters,
-#endif
 	.attach_adapter  = tvmixer_adapters,
 	.detach_client   = tvmixer_clients,
 };
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 5e19a7b..0316ba1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -252,11 +252,6 @@ static inline void i2c_set_adapdata (str
 
 /*flags for the driver struct: */
 #define I2C_DF_NOTIFY	0x01		/* notify on bus (de/a)ttaches 	*/
-#if 0
-/* this flag is gone -- there is a (optional) driver->detach_adapter
- * callback now which can be used instead */
-# define I2C_DF_DUMMY	0x02
-#endif
 
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */


