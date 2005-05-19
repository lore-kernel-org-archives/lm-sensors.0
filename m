From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc1
Message-Id: <11003020053782@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11003020054093@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2094, 2004/11/12 11:40:22-08:00, greg@kroah.com

I2C: fix up rtc8564 which should not have been changed in my previous cleanups.

This fixes a reported oops.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/rtc8564.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
--- a/drivers/i2c/chips/rtc8564.c	2004-11-12 15:22:45 -08:00
+++ b/drivers/i2c/chips/rtc8564.c	2004-11-12 15:22:45 -08:00
@@ -66,8 +66,11 @@
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_addr,
+	.normal_i2c_range	= ignore,
 	.probe			= ignore,
+	.probe_range		= ignore,
 	.ignore			= ignore,
+	.ignore_range		= ignore,
 	.force			= ignore,
 };
 

