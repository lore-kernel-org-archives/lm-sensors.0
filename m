From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jun 2007 11:58:04 +0000
Subject: [lm-sensors] Converting vt8231 to a platform driver
Message-Id: <20070603135804.3aa2b7fb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

I would like to get rid of i2c-isa soon now. One of the last few users
is your vt8231 driver. It needs to be converted to a platform driver
before I can delete i2c-isa. Would you possibly take care of it? The
conversion should be similar to what I did for the via686a driver a few
days ago:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019838.html

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
