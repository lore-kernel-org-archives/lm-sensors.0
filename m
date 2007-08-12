From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 13:45:24 +0000
Subject: Re: [lm-sensors] lmsensors 2.x: how to hide entry from 2.4 driver
Message-Id: <20070812154524.413a58ac@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Thu, 26 Jul 2007 23:18:31 +0200, Krzysztof Helt wrote:
> The THMC50 driver for the 2.4 kernel has a feature called "die code".
> It does not exists in the 2.6 driver. How should I hide it so no message:
> 
> "ERROR: Can't get feature `die_code' data!"
> 
> is not displayed.
>
> Another question is to how to hide one of tempX features if it does not
> exists (it depends on chip working mode). The chip name is the same for
> both modes.

If you are using "sensors -u", you can't. This mode was only meant for
testing. If you want a clean output for your chip, you'll have to add a
dedicated printing routine for it (in prog/sensors/chips.c).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
