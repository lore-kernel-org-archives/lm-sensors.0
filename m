From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH 2.6] I2C: Fix race condition in it87 driver
Message-Id: <20050324223901.23beb827.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I noticed a race condition in the it87, affecting the IT8712F chip only.
The VRM value is currently initialized *after* creating the vrm and vid
sysfs files. This leaves a theorical room for reading from these files
and get an invalid value. It's not critical, but let's still fix it.

Please apply, thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-mm1/drivers/i2c/chips/it87.c.orig	Thu Mar 24 14:06:35 2005
+++ linux-2.6.12-rc1-mm1/drivers/i2c/chips/it87.c	Thu Mar 24 14:08:24 2005
@@ -889,9 +889,9 @@
 	}
 
 	if (data->type = it8712) {
+		data->vrm = i2c_which_vrm();
 		device_create_file_vrm(new_client);
 		device_create_file_vid(new_client);
-		data->vrm = i2c_which_vrm();
 	}
 
 	return 0;


-- 
Jean Delvare
