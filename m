From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH 2.6] Fix adm1021 alarms mask
Message-Id: <20050306083758.2f97cf9d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch fixes an incorrect bitmasking on the status register in the
adm1021 driver, which was causing high alarm on remote temperature to be
hidden.
This bug was found and reported by Jayakrishnan:
  http://bugzilla.kernel.org/show_bug.cgi?idB85

Please apply,
thanks.

Signed-off-by: Jean Delvare

--- linux-2.6.11-mm1/drivers/i2c/chips/adm1021.c.orig	Fri Dec 24 22:33:49 2004
+++ linux-2.6.11-mm1/drivers/i2c/chips/adm1021.c	Fri Mar  4 13:03:33 2005
@@ -380,7 +380,7 @@
 		data->remote_temp_input = adm1021_read_value(client, ADM1021_REG_REMOTE_TEMP);
 		data->remote_temp_max = adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
 		data->remote_temp_hyst = adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
-		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0xec;
+		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0x7c;
 		if (data->type = adm1021)
 			data->die_code = adm1021_read_value(client, ADM1021_REG_DIE_CODE);
 		if (data->type = adm1023) {



-- 
Jean Delvare
