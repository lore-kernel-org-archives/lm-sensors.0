From: Gabriel C <nix.or.die@googlemail.com>
Date: Sat, 21 Jul 2007 22:30:56 +0000
Subject: [lm-sensors] drivers/hwmon - 'defined but not used' warnings
Message-Id: <46A28920.9060704@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: mhoffman@lightlink.com, lm-sensors@lm-sensors.org

Hi ,

I noticed this warnings on current git:

...

drivers/hwmon/pc87360.c:1082: warning: 'pc87360_remove' defined but not used
drivers/hwmon/sis5595.c:580: warning: 'sis5595_remove' defined but not used
drivers/hwmon/smsc47m1.c:608: warning: 'smsc47m1_remove' defined but not used
drivers/hwmon/via686a.c:648: warning: 'via686a_remove' defined but not used
drivers/hwmon/vt8231.c:755: warning: 'vt8231_remove' defined but not used

...


Regards,

Gabriel C

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
