From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:56:28 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop out-of-date,
Message-Id: <1130533660668@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop out-of-date, colliding ioctl definitions

Delete 2 out-of-date, colliding ioctl defines. I2C_UDELAY and
I2C_MDELAY are supposed to be used by i2c-algo-bit, but actually
aren't (and I suspect never were). Moreover, their values are the same
as I2C_FUNCS and I2C_SLAVE_FORCE, respectively, which *are* widely
used.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 80ce3b7d0f52877b80cddc3ace8b332d888f0131
tree 8ca3be85ad953a8a9c874e1c0e805dcd7314c19a
parent 31ec5bc57146a479fac6f6878146059180413e43
author Jean Delvare <khali@linux-fr.org> Sat, 08 Oct 2005 00:06:09 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:09 -0700

 include/linux/i2c.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 6a1f342..74103d0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -503,11 +503,6 @@ union i2c_smbus_data {
 
 #define I2C_SMBUS	0x0720	/* SMBus-level access */
 
-/* ... algo-bit.c recognizes */
-#define I2C_UDELAY	0x0705	/* set delay in microsecs between each	*/
-				/* written byte (except address)	*/
-#define I2C_MDELAY	0x0706	/* millisec delay between written bytes */
-
 /* ----- I2C-DEV: char device interface stuff ------------------------- */
 
 #define I2C_MAJOR	89		/* Device major number		*/

