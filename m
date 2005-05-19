From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <10559607081420@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10559607081639@kroah.com>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1318.3.5, 2003/06/16 11:32:48-07:00, greg@kroah.com

[PATCH] I2C: add lm78 chip to Makefile


 drivers/i2c/chips/Makefile |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Wed Jun 18 11:19:30 2003
+++ b/drivers/i2c/chips/Makefile	Wed Jun 18 11:19:30 2003
@@ -5,6 +5,7 @@
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
+obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o

