From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 24 Aug 2006 15:05:20 +0000
Subject: [lm-sensors] it8718 under 2.6
Message-Id: <20060824170520.ad92a6de.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Shane,

> Ok, I've found the patch on the newdrivers section of the
> lm-sensors wiki which worked.  As the entry says testers
> needed, here are my results.

Great, thanks for reporting. Which kernel are you running?

>                               There was no config entry for
> the 8718 so I just used the 8716 entry which doesn't seem
> fully compatable.  12v is wrong and temp3 as well though
> not sure if temp3 is enabled on the board.

I was waiting to have some more reports, as the first board I had a
report for had a somewhat non-standard configuration.

Please go to the BIOS setup screen and write down everything it says
about voltages, fans and temperatures (labels and values, in order.)
Then report this list here, together with the output of "sensors"
without a configuration file (either delete it, or run "sensors
-c /dev/null"). I'll help you come up with a working configuration file
for your board.

Oh, the driver is also trying to help with messages in the logs when
you load it. Please report these messages.

> Also, fan 4 and fan 5 aren't shown in the sensors output.

I have not seen a board using these yet, so I didn't bother adding
support. I could add it if you need it. What do you offer?

FYI, I just updated the 2.6.18 version of my patch:
http://jdelvare.pck.nerim.net/sensors/hwmon-it8716f-it8718f-v2-2.6.18.patch

It should work as least as well as the first one, the fan part is a bit
better. Please give it a try if you are running a 2.6.18-rc kernel. I
don't quite have the time to backport this one to earlier kernels.

-- 
Jean Delvare

