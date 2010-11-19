From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 19 Nov 2010 14:48:31 +0000
Subject: [lm-sensors] Build warning in i5k_amb.c
Message-Id: <20101119144831.GB17616@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

the following build warning is reported in the "Build regressions/improvements in v2.6.37-rc2"
post sent to lkml.

drivers/hwmon/i5k_amb.c:500: warning: 'i5k_amb_ids' defined but not used: 1 warnings in 1 logs
        v2.6.37-rc2/powerpc/powerpc-allyesconfig

Any idea how to fix it ? I am a bit at loss about what is going on.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
