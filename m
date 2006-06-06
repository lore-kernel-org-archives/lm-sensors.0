From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 06 Jun 2006 13:49:20 +0000
Subject: [lm-sensors] [PATCH] OpenCores I2C bus driver
Message-Id: <87ac8qs8bj.fsf@slug.be.48ers.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <874q0n1505.fsf@sleipner.barco.com>
In-Reply-To: <874q0n1505.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "Jean" = Jean Delvare <khali at linux-fr.org> writes:

 Jean> Hi Peter,
 >> >>>>> "Peter" = Peter Korsgaard <jacmet at sunsite.dk> writes:
 >> 
 Peter> And here it is - Changes since last time:
 >> 
 Peter> - Minor cleanups from Andrew Morton (2.6.17-rc3-mm1)
 Peter> - Better handling of reserved bits as suggested by Rudolf Marek
 Peter> - Documentation
 >> 
 >> Comments?

 Jean> Sorry for the long delay. I finally took some time to (briefly) review
 Jean> your code. It looks OK overall, and I've applied it with the following
 Jean> changes I hope you'll approve:

No problem - Thanks for the review. Your changes looks fine to me.

 >> #define OCI2C_CMD		4
 >> #define OCI2C_STATUS		4

 Jean> Two registers with the same number? If it's true this deserves a
 Jean> comment, methinks.

Yes, comment added in patch below.

 >> static struct i2c_adapter ocores_adapter = {
 >> .owner		= THIS_MODULE,
 >> .name		= "i2c-ocores",
 >> .class		= I2C_CLASS_HWMON,
 >> .algo		= &ocores_algorithm,
 >> .timeout	= 2,
 >> .retries	= 1,
 >> };

 Jean> Why define .timeout and .retries if you don't use them in your driver?

Sorry, I guess that was a case of too much cut'n'paste - fixed below.

 Jean> Last, I would like you to become the maintainer for this new driver if
 Jean> you feel like it. If you accept, please send a patch to MAINTAINERS and
 Jean> I'll apply it.

Added below.

Signed-off-by: Peter Korsgaard <jacmet at sunsite.dk>
---
 MAINTAINERS                     |    6 ++++++
 drivers/i2c/busses/i2c-ocores.c |    6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

--- linux.orig/MAINTAINERS	2006-06-06 16:59:27.000000000 +0200
+++ linux/MAINTAINERS	2006-06-06 17:05:19.000000000 +0200
@@ -2045,6 +2045,12 @@
 L:      linux-fbdev-devel at lists.sourceforge.net
 S:      Maintained
 
+OPENCORES I2C BUS DRIVER
+P:	Peter Korsgaard
+M:	jacmet at sunsite.dk
+L:	lm-sensors at lm-sensors.org
+S:	Maintained
+
 ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
 P:	Mark Fasheh
 M:	mark.fasheh at oracle.com
--- linux.orig/drivers/i2c/busses/i2c-ocores.c	2006-06-06 16:59:19.000000000 +0200
+++ linux/drivers/i2c/busses/i2c-ocores.c	2006-06-06 17:02:18.000000000 +0200
@@ -38,8 +38,8 @@
 #define OCI2C_PREHIGH		1
 #define OCI2C_CONTROL		2
 #define OCI2C_DATA		3
-#define OCI2C_CMD		4
-#define OCI2C_STATUS		4
+#define OCI2C_CMD		4 /* write only */
+#define OCI2C_STATUS		4 /* read only, same address as OCI2C_CMD */
 
 #define OCI2C_CTRL_IEN		0x40
 #define OCI2C_CTRL_EN		0x80
@@ -209,8 +209,6 @@
 	.name		= "i2c-ocores",
 	.class		= I2C_CLASS_HWMON,
 	.algo		= &ocores_algorithm,
-	.timeout	= 2,
-	.retries	= 1,
 };
 
 

-- 
Bye, Peter Korsgaard

