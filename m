From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: Make i2c list terminators explicitely unsigned
Message-Id: <11099685962273@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685962988@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2107, 2005/03/02 15:02:10-08:00, khali@linux-fr.org

[PATCH] I2C: Make i2c list terminators explicitely unsigned

Shouldn't the i2c list terminators be explicitely declared as unsigned?
I'd hope it to help code analysis tools and possibly avoid false
positives. Coverity's SWAT pointed my attention to these constants.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/i2c.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:23:42 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:23:42 -08:00
@@ -299,8 +299,8 @@
 };
 
 /* Internal numbers to terminate lists */
-#define I2C_CLIENT_END		0xfffe
-#define I2C_CLIENT_ISA_END	0xfffefffe
+#define I2C_CLIENT_END		0xfffeU
+#define I2C_CLIENT_ISA_END	0xfffefffeU
 
 /* The numbers to use to set I2C bus address */
 #define ANY_I2C_BUS		0xffff

