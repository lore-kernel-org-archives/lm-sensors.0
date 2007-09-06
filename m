From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Sep 2007 11:06:00 +0000
Subject: [lm-sensors] Missing thmc50 support in sensors
Message-Id: <20070906130600.028cf7f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

In ticket #2250, someone using your new thmc50 driver is complaining
about the lack of pretty-print support in "sensors":

http://www.lm-sensors.org/ticket/2250#comment:2

Could you possibly provide a patch adding support? You can simply copy
the code for a similar chip in prog/sensors/chips.c (for example lm63)
and adjust it for the thmc50 symbols.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
