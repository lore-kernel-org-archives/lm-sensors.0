From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Mar 2013 14:10:04 +0000
Subject: [lm-sensors] [PATCH 0/5] lm75 driver improvements
Message-Id: <20130312151004.033a456a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I worked on improving the lm75 driver:

hwmon: (lm75) Fix tcn75 prefix
hwmon: (lm75) Per-chip configuration register initialization
hwmon: (lm75) Prepare to support per-chip resolution and sample time
hwmon: (lm75) Tune resolution and sample time per chip
hwmon: (lm75) Add support for the Dallas/Maxim DS1705

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
