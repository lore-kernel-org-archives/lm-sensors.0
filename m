From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Nov 2013 08:46:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Fix max6696 alarm handling
Message-Id: <20131104094636.06f68dae@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 30 Oct 2013 10:04:34 -0700, Guenter Roeck wrote:
> Bit 2 of status register 2 on MAX6696 (external diode 2 open)
> sets ALERT; the bit thus has to be listed in alert_alarms.
> Also display a message in the alert handler if the condition
> is encountered.
> 
> Even though not all overtemperature conditions cause ALERT
> to be set, we should not ignore them in the alert handler.
> Display messages for all out-of-range conditions.

Thanks for the fix, it looks good, applied.

> Reported-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Not sure how this fits into the ongoing restructuring.
> I may have to apply some of the other patches first; let me know.

As this is a bug fix, I want to apply it first so that it can be
backported easily. In fact I will even request it to go to the stable
kernels, as I think it is important.

So the other patches (from Wei) will indeed need some adjustments to go
on top of it. I'll take care of that myself.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
