From: James Cloos <cloos@jhcloos.com>
Date: Sat, 24 Sep 2011 23:53:12 +0000
Subject: [lm-sensors] fan change between 3.1.0-rc6 and commit b172e38
Message-Id: <m339flbipr.fsf@jhcloos.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Did something change in the f71889ed support between rc6 and today?

Up until rc6 my am3+phenom board ran its fan at about 800 Hz most of the
time, with occasional bursts to 1200 Hz or so when under heavy load.

With b172e38 it runs at around 2048 Hz.  *Loudly*.

(The only fan monitored is connected via the board's cpufan socket, and
is a 12cm 3-wire fan attached to a 12x12x6 (or so) cm heat sink.)

The cpu is running about 16 Kelvins colder than the in-case ambient,
instead of around 2 Kelvins colder.

But the noise is worse than a window fan.

The only change was the reboot into the newer kernel.

I haven't run into the particular presentation before, but it seems
worrysome.  Should I worry?

pwmconfig is not able to stop the fan, if that is relevant.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
