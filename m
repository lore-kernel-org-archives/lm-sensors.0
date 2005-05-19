From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Xeon II motherboard and CPU temp readings
Message-Id: <Pine.LNX.4.58.0406182240440.6087@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
In-Reply-To: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

>      Am I doing something wrong or can this been fixed?
Yes both things can be fixed.

> fan1:        0 RPM  (min = 3000 RPM, div = 2)
> fan2:        0 RPM  (min = 3000 RPM, div = 2)
> fan3:        0 RPM  (min = 3000 RPM, div = 2)

You need to change the "fan divisor".  Try 4 or 8 in this order.
You can do it by editing  sensor.conf file. Find the corresponding
section in your configuration  file. It will start from line with
chip  "w83627hf-*"
(or similar)

You can add

set fan1_div 4
set fan2_div 4
..

Note you can also set lower limits with
set fan1_min xxx
set fan2_min xxx

When finished with editing run sensors -s to propagate the changes.

Before that you can try to solve CPU temp problems.

> modprobe adm1021

Please make sure you loaded this module, but before
remove BOTH lines from modules.conf

> options adm1021 ignore=0,0x19
> options w83781d ignore=0,0x2c

Your roadmap of changes should be:

1) remove options lines from modules.conf (or conf.modules)
2) reload both modules rmmod/modprobe
3) edit sensors.conf
4) sensors -s
5) sensors

I hope this helps.

Regards

Rudolf
