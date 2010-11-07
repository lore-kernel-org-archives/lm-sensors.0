From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Nov 2010 15:31:33 +0000
Subject: [lm-sensors] [PATCH 0/7] More w83795 driver fixes
Message-Id: <20101107163133.628dc371@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have 7 more patches ready, fixing various problems in the w83795
driver. My to-do list is still long, but I would like to have at least
these fixes in kernel 2.6.37.

[PATCH 1/7] hwmon: (w83795) Fix fan control mode attributes
[PATCH 2/7] hwmon: (w83795) Expose fan control method
[PATCH 3/7] hwmon: (w83795) List all usable temperature sources
[PATCH 4/7] hwmon: (w83795) Print the actual temperature channels as sources
[PATCH 5/7] hwmon: (w83795) Read the intrusion state properly
[PATCH 6/7] hwmon: (w83795) Clear intrusion alarm immediately
[PATCH 7/7] hwmon: (w83795) Check for BEEP pin availability

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
