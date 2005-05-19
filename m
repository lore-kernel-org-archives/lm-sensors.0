From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: Fix adm1021 alarms mask
Message-Id: <1112311390426@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113902974@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2326, 2005/03/31 14:06:28-08:00, khali@linux-fr.org

[PATCH] I2C: Fix adm1021 alarms mask

This patch fixes an incorrect bitmasking on the status register in the
adm1021 driver, which was causing high alarm on remote temperature to be
hidden.
This bug was found and reported by Jayakrishnan:
  http://bugzilla.kernel.org/show_bug.cgi?idB85


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/adm1021.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2005-03-31 15:18:52 -08:00
+++ b/drivers/i2c/chips/adm1021.c	2005-03-31 15:18:52 -08:00
@@ -368,7 +368,7 @@
 		data->remote_temp_input = adm1021_read_value(client, ADM1021_REG_REMOTE_TEMP);
 		data->remote_temp_max = adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
 		data->remote_temp_hyst = adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
-		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0xec;
+		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0x7c;
 		if (data->type = adm1021)
 			data->die_code = adm1021_read_value(client, ADM1021_REG_DIE_CODE);
 		if (data->type = adm1023) {

