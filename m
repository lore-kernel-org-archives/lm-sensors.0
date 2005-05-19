From: Alain@Valleton.org (Alain VALLETON)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Little patch for old gcc (lm_sensors 2.8.8)
Message-Id: <41B63AD4.4050805@Valleton.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Otherwise compilation of lm_sensors 2.8.8 fails with gcc 2.95.3

Have a nice day,



diff -Naur lm_sensors-2.8.8/kernel/chips/lm93.c lm_sensors-2.8.8_new/kernel/chips/lm93.c
--- lm_sensors-2.8.8/kernel/chips/lm93.c	2004-09-15 15:27:45.000000000 +0200
+++ lm_sensors-2.8.8_new/kernel/chips/lm93.c	2004-12-08 00:08:04.000000000 +0100
@@ -1678,6 +1678,7 @@
 {
 	struct lm93_data *data = client->data;
 	int nr = ctl_name - LM93_SYSCTL_FAN1_SMART_TACH;
+	int mapping = 0;
 
 	if (0 > nr || nr > 3)
 		return; /* ERROR */
@@ -1688,7 +1689,7 @@
 		lm93_update_client(client);
 
 		/* extract the relevant mapping */
-		int mapping = (data->sf_tach_to_pwm >> (nr * 2)) & 0x03;
+		mapping = (data->sf_tach_to_pwm >> (nr * 2)) & 0x03;
 
 		/* if there's a mapping and it's enabled */
 		if (mapping && ((data->sfc2 >> nr) & 0x01))
