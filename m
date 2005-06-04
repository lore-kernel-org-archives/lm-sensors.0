From: se.witt@gmx.net (Sebastian Witt)
Date: Sat, 04 Jun 2005 16:50:25 +0000
Subject: [lm-sensors] [PATCH]: Update it87 documentation for automatic mode
Message-Id: <42A1BFD1.6020903@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Adds documentation for the automatic "Smart Guardian" mode it87 patch.

Regards,
Sebastian
-------------- next part --------------
--- linux-2.6.12-rc5-mm2_orig/Documentation/i2c/chips/it87	2005-06-04 16:27:48.000000000 +0200
+++ linux-2.6.12-rc5-mm2/Documentation/i2c/chips/it87	2005-06-04 16:41:59.000000000 +0200
@@ -91,6 +91,14 @@
 startup, consult lm_sensors's /etc/sensors.conf. (2 = thermistor;
 3 = thermal diode)
 
-The fan speed control features are limited to manual PWM mode. Automatic
-"Smart Guardian" mode control handling is not implemented. However
-if you want to go for "manual mode" just write 1 to pwmN_enable.
+There are two different fan speed control modes. For the first, manual
+PWM mode, write 1 to pwmN_enable and the PWM value to pwmN. For automatic
+"Smart Guardian" mode write 2 to pwmN_enable. The PWM start value for this
+mode goes in pwmN_start, the temperature input to use in pwmN_temp_input,
+the temperature when the fan is started in pwmN_limit_start. The fan gets
+disabled if the temperature in pwmN_limit_off is reached. Between the
+temperatures in pwmN_limit_start and pwmN_limit_full, the fan speed is 
+linear increased by pwmN_step. pwmN_step ranges from 0 to 7, which means 
+0,1,2,4,8,16,32 or 64 PWM increments per temperature increase. 
+This means pwmN = pwmN_start + temp[pwmN_temp_input]_input * pwmN_step
+between pwmN_limit_start and pwmN_limit_full.
