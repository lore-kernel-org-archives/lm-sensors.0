From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: lm_sensors problem with sis96x and adm1021
Message-Id: <20041211132843.4f0261be.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B9BDFD.6070102@gmx.de>
In-Reply-To: <41B9BDFD.6070102@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yes right, after running sensors -s the values for Board changed to
> the values I defined. As you suggested 0 for low and 70 for high.
> The values for CPU however did not apply. The default values are 0
> low and 55 high when the fan is off and change to 50 low and
> 70 high when the fan is turned on. However inserting the values
> through sysfs did work, but the values are overriden as soon as the
> fan starts spinning again.

The MAX6657 is not able to do that by itself. It has alarm outputs that
can tell another chip on your system to do it, though. Reprogramming the
limits on the fly does sound weird, there are better ways to achieve
conditional fan activity.

> Sorry I can't crack the case open ;-) sensors-detect didn't suggest
> anything except sis-96x I'll drop the complete output here. So I just
> modprobed all modules and the only one that did show something was
> adm1021.

This is odd. I had expected that sensors-detect would suggest both the
adm1021 driver (for a MAX1617) and the lm90 driver (for a MAX6657), and
pick the former arbitrarily. When comparing the sensors-detect code with
the dump you sent, I just cannot get why it isn't the case. Both tests
(MAX1617 and MAX6657) should be positive. Are you certain that you are
using an up-to-date version of sensors-detect? Please try with the CVS
version:

http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect

If it still won't detect your chip as neither a MAX1617 nor a MAX6657,
and you have some perl knowledge, it would be great if you could add
some debug in the adm1021_detect and lm90_detect functions (for $chip=2
and $chip=4, respectively) and see where the detection is failing
exactly. If you don't have such a knowledge I'll send you a modified
version of the script for you to test it.

> Client found at address 0x10
> (...)
> Client found at address 0x6a

I wonder what these are. Could you please provide dumps of these as
well?

I'd also be interested to know the model name of your laptop, in case I
can find some technical documentation.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
