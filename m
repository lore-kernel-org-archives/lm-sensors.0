From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] Trivial indentation fix in i2c/chips/Kconfig
Message-Id: <20050302194522.2512fe02.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4224C0D4.2060303@katalix.com>
	<cIyC5ZN2.1109756623.5808030.khali@localhost>
In-Reply-To: <cIyC5ZN2.1109756623.5808030.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: James Chapman <jchapman@katalix.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

Hi Greg,

Quoting myself:

> (...) I also think I see an indentation issue on the "tristate" line,
> seemingly copied from the SENSORS_DS1621 section which would need to
> be fixed as well.

Here is the trivial patch fixing that, if you want to apply it.

Thanks,

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11/drivers/i2c/chips/Kconfig.orig	Wed Mar  2 15:12:34 2005
+++ linux-2.6.11/drivers/i2c/chips/Kconfig	Wed Mar  2 15:15:12 2005
@@ -63,7 +63,7 @@
 	  will be called asb100.
 
 config SENSORS_DS1621
-      	tristate "Dallas Semiconductor DS1621 and DS1625"
+	tristate "Dallas Semiconductor DS1621 and DS1625"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help


-- 
Jean Delvare
