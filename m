From: Ioan Rusan <ionica@bolovan.homelinux.com>
Date: Wed, 29 Sep 2010 18:54:16 +0000
Subject: [lm-sensors] fancontrol writhed in C
Message-Id: <4CA38B58.80905@bolovan.homelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I writhed a new version of fancontrol in C.
Some bugs corrected and some improvements:
Add hdd temp support (is using hddtemp daemon)
force_start (some fans have doesn't start at some small values, but are 
able to run at that speed, and for this, before setting small values, if 
fans are stopped...is set for 90 ms at maximum speed)
And the address for download: http://bolovan.homelinux.com/ionica/fancontrol

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
