From: domen@coderock.org (Domen Puncer)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [trivial patch] i2c/it87: add newline to printk
Message-Id: <20050125110538.GA4459@nd47.coderock.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This printk should have newline, otherwise next string is appended to it.
Boot tested.


Signed-off-by: Domen Puncer <domen@coderock.org>

--- c/drivers/i2c/chips/it87.c	2005-01-22 02:48:35.000000000 +0100
+++ a/drivers/i2c/chips/it87.c	2005-01-25 11:43:42.000000000 +0100
@@ -835,7 +835,7 @@
 	if ((tmp & 0x87) = 0) {
 		enable_pwm_interface = 0;
 		dev_info(&new_client->dev,
-			"detected broken BIOS defaults, disabling pwm interface");
+			"detected broken BIOS defaults, disabling pwm interface\n");
 	}
 
 	/* Register sysfs hooks */
