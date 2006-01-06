From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:35 +0000
Subject: [lm-sensors] [PATCH] i2c: Rework client usage count, 1 of 3
Message-Id: <11365852551513@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852552960@kroah.com>
In-Reply-To: <11365852552960@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Rework client usage count, 1 of 3

No i2c client uses the I2C_CLIENT_ALLOW_MULTIPLE_USE flag, drop it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit cb748fb20186d4b345c68a7f580429f379fdd268
tree 6c8f4f0937941bb4ee56ed72ba0b7f60562f1e1d
parent 5d7b851dcced3611e4a4432308618b1ed1a9fc31
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 20:58:35 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:22 -0800

 drivers/i2c/i2c-core.c |    4 +---
 include/linux/i2c.h    |    2 --
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ad68ac0..2f0bc95 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -500,9 +500,7 @@ int i2c_use_client(struct i2c_client *cl
 		return ret;
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE) {
-		if (client->flags & I2C_CLIENT_ALLOW_MULTIPLE_USE)
-			client->usage_count++;
-		else if (client->usage_count > 0) 
+		if (client->usage_count > 0)
 			goto busy;
 		else 
 			client->usage_count++;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 3c16a8f..4487c51 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -251,8 +251,6 @@ static inline void i2c_set_adapdata (str
 
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
-#define I2C_CLIENT_ALLOW_MULTIPLE_USE 	0x02  	/* Allow multiple access-locks */
-						/* on an i2c_client */
 #define I2C_CLIENT_PEC  0x04			/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */


