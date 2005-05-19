From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [PATCH] I2C update for 2.6.6
Message-Id: <1084577357292@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10845773571402@kroah.com>
References: <10845773562431@kroah.com>
In-Reply-To: <10845773562431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1587.15.7, 2004/05/05 15:33:39-07:00, khali@linux-fr.org

[PATCH] I2C: Sensors (W83627HF) in Tyan S2882


 drivers/i2c/chips/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Fri May 14 16:20:40 2004
+++ b/drivers/i2c/chips/Kconfig	Fri May 14 16:20:40 2004
@@ -163,7 +163,7 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
 	  and the similar Asus AS99127F.
 	  
 	  This driver can also be built as a module.  If so, the module

