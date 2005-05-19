From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [PATCH] I2C update for 2.6.7-rc1
Message-Id: <1085781643301@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10857816433753@kroah.com>
References: <1085781643100@kroah.com>
In-Reply-To: <1085781643100@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1717.6.26, 2004/05/19 00:25:54-07:00, ebs@ebshome.net

[PATCH] I2C PPC4xx IIC driver: Kconfig cleanup

this patch renames Kconfig entry for PPC4xx IIC driver making it more clear and
also adds a help text.


 drivers/i2c/busses/Kconfig |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Fri May 28 14:52:22 2004
+++ b/drivers/i2c/busses/Kconfig	Fri May 28 14:52:22 2004
@@ -118,8 +118,14 @@
 	  will be called i2c-i810.
 
 config I2C_IBM_IIC
-	tristate "IBM IIC I2C"
+	tristate "IBM PPC 4xx on-chip I2C interface"
 	depends on IBM_OCP && I2C
+	help
+	  Say Y here if you want to use IIC peripheral found on 
+	  embedded IBM PPC 4xx based systems. 
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ibm_iic.
 
 config I2C_IOP3XX
 	tristate "Intel XScale IOP3xx on-chip I2C interface"

