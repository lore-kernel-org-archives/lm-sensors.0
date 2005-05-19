From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: [PATCH] i2c driver changes for 2.5.67
Message-Id: <10499274992901@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030409223117.GA2812@kroah.com>
References: <10499274993464@kroah.com>
In-Reply-To: <10499274993464@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1033.3.1, 2003/04/07 09:31:20-07:00, greg@kroah.com

i2c: fix up CONFIG_I2C_SENSOR configuration logic.

Thanks to Ardrian Bunk for help with this.


 drivers/i2c/chips/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Wed Apr  9 15:17:08 2003
+++ b/drivers/i2c/chips/Kconfig	Wed Apr  9 15:17:08 2003
@@ -66,7 +66,8 @@
 
 config I2C_SENSOR
 	tristate
-	depends on SENSORS_ADM1021 || SENSORS_LM75 || SENSORS_VIA686A || SENSORS_W83781D
-	default m
+	default y if SENSORS_ADM1021=y || SENSORS_LM75=y || SENSORS_VIA686A=y || SENSORS_W83781D=y
+	default m if SENSORS_ADM1021=m || SENSORS_LM75=m || SENSORS_VIA686A=m || SENSORS_W83781D=m
+	default n
 
 endmenu

