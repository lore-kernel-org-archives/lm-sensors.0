From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH] I2C: Fix bogus bitmask in lm63 debug message
Message-Id: <11059983951840@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11059983953842@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2329.2.5, 2005/01/14 14:42:49-08:00, khali@linux-fr.org

[PATCH] I2C: Fix bogus bitmask in lm63 debug message

There is a bitmask error in one debug message of my lm63 chip driver.
Nothing critical but still worth fixing, hence comes a patch.

Credits go to Mohan Mistry for finding the error.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm63.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c	2005-01-17 13:20:43 -08:00
+++ b/drivers/i2c/chips/lm63.c	2005-01-17 13:20:43 -08:00
@@ -464,8 +464,8 @@
 		(data->config & 0x04) ? "tachometer input" :
 		"alert output");
 	dev_dbg(&client->dev, "PWM clock %s kHz, output frequency %u Hz\n",
-		(data->config_fan & 0x04) ? "1.4" : "360",
-		((data->config_fan & 0x04) ? 700 : 180000) / data->pwm1_freq);
+		(data->config_fan & 0x08) ? "1.4" : "360",
+		((data->config_fan & 0x08) ? 700 : 180000) / data->pwm1_freq);
 	dev_dbg(&client->dev, "PWM output active %s, %s mode\n",
 		(data->config_fan & 0x10) ? "low" : "high",
 		(data->config_fan & 0x20) ? "manual" : "auto");

