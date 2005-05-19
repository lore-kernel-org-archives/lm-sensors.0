From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [PATCH] I2C update for 2.6.7-rc1
Message-Id: <10857816431154@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1085781643301@kroah.com>
References: <1085781643100@kroah.com>
In-Reply-To: <1085781643100@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1717.6.27, 2004/05/19 00:26:13-07:00, ebs@ebshome.net

[PATCH] I2C PPC4xx IIC driver: fix debug build with gcc3

this patch fixes PPC4xx IIC driver debug mode build with gcc 3.x compiler.
Noticed by Evgenij Polyakov.


 drivers/i2c/busses/i2c-ibm_iic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:17 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:17 2004
@@ -69,14 +69,14 @@
 #endif
 
 #if DBG_LEVEL > 0
-#  define DBG(x...)	printk(KERN_DEBUG "ibm-iic" ##x)
+#  define DBG(f,x...)	printk(KERN_DEBUG "ibm-iic" f, ##x)
 #else
-#  define DBG(x...)	((void)0)
+#  define DBG(f,x...)	((void)0)
 #endif
 #if DBG_LEVEL > 1
-#  define DBG2(x...) 	DBG( ##x )
+#  define DBG2(f,x...) 	DBG(f, ##x)
 #else
-#  define DBG2(x...) 	((void)0)
+#  define DBG2(f,x...) 	((void)0)
 #endif
 #if DBG_LEVEL > 2
 static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)

