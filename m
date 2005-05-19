From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test3
Message-Id: <1060972406382@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1060972406359@kroah.com>
References: <1060972405413@kroah.com>
In-Reply-To: <1060972405413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1123.18.4, 2003/08/11 15:22:22-07:00, greg@kroah.com

i2c: move w83481d to top of link order due to chip address takeover ability.

Fixes http://bugme.osdl.org/show_bug.cgi?id66


 drivers/i2c/chips/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Fri Aug 15 11:27:01 2003
+++ b/drivers/i2c/chips/Makefile	Fri Aug 15 11:27:01 2003
@@ -2,10 +2,12 @@
 # Makefile for the kernel hardware sensors chip drivers.
 #
 
+# w83781d goes first, as it can override other driver's addresses.
+obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
+
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
 obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
-obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o

