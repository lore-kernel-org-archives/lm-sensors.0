From: Jesper Juhl <jj@chaosbits.net>
Date: Sat, 02 Jul 2011 20:04:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: Don't leak info in adm1275_probe
Message-Id: <alpine.LNX.2.00.1107022202520.16316@swampdragon.chaosbits.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>

In drivers/hwmon/adm1275.c:adm1275_probe() we'll leak the memory
allocated to 'info' if the call to i2c_smbus_read_byte_data() returns
less than zero.

This patch fixes the leak by simply calling kfree(info) when needed.
I also considered just moving the 'info' memory allocation below the
call to i2c_smbus_read_byte_data(), but I was not sure if it mattered
to get the -ENOMEM first in that case or if it would be bad to first
have a successful i2c_smbus_read_byte_data() call and then fail the
mem alloc, so I stuck with the safe option.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/hwmon/adm1275.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

  Compile tested only.

diff --git a/drivers/hwmon/adm1275.c b/drivers/hwmon/adm1275.c
index c2ee204..2ebf255 100644
--- a/drivers/hwmon/adm1275.c
+++ b/drivers/hwmon/adm1275.c
@@ -43,8 +43,10 @@ static int adm1275_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
-	if (config < 0)
+	if (config < 0) {
+		kfree(info);
 		return config;
+	}
 
 	info->pages = 1;
 	info->direct[PSC_VOLTAGE_IN] = true;
-- 
1.7.6


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
