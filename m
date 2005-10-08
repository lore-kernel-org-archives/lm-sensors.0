From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Oct 2005 00:06:35 +0000
Subject: [lm-sensors] [PATCH 08/16] i2c: Drop out-of-date,
Message-Id: <20051008000609.5846697a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Delete 2 out-of-date, colliding ioctl defines. I2C_UDELAY and
I2C_MDELAY are supposed to be used by i2c-algo-bit, but actually
aren't (and I suspect never were). Moreover, their values are the same
as I2C_FUNCS and I2C_SLAVE_FORCE, respectively, which *are* widely
used.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c.h |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2.6.14-rc3.orig/include/linux/i2c.h	2005-10-07 20:56:57.000000000 +0200
+++ linux-2.6.14-rc3/include/linux/i2c.h	2005-10-07 21:03:21.000000000 +0200
@@ -503,11 +503,6 @@
 
 #define I2C_SMBUS	0x0720	/* SMBus-level access */
 
-/* ... algo-bit.c recognizes */
-#define I2C_UDELAY	0x0705	/* set delay in microsecs between each	*/
-				/* written byte (except address)	*/
-#define I2C_MDELAY	0x0706	/* millisec delay between written bytes */
-
 /* ----- I2C-DEV: char device interface stuff ------------------------- */
 
 #define I2C_MAJOR	89		/* Device major number		*/

-- 
Jean Delvare
