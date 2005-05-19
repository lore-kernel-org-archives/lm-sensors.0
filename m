From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH] I2C: Fix race condition in it87 driver
Message-Id: <11123113953775@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113941998@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2345, 2005/03/31 14:31:21-08:00, khali@linux-fr.org

[PATCH] I2C: Fix race condition in it87 driver

I noticed a race condition in the it87, affecting the IT8712F chip only.
The VRM value is currently initialized *after* creating the vrm and vid
sysfs files. This leaves a theorical room for reading from these files
and get an invalid value. It's not critical, but let's still fix it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/it87.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-03-31 15:16:31 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-03-31 15:16:31 -08:00
@@ -889,9 +889,9 @@
 	}
 
 	if (data->type = it8712) {
+		data->vrm = i2c_which_vrm();
 		device_create_file_vrm(new_client);
 		device_create_file_vid(new_client);
-		data->vrm = i2c_which_vrm();
 	}
 
 	return 0;

