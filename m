From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Jun 2015 22:27:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ntc: Improve precision of resistance calculation
Message-Id: <556F7F6D.8010407@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1433270907-24933-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1433270907-24933-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/02/2015 01:57 PM, Chris Lesiak wrote:
> The function get_ohm_of_thermistor has both the measured voltage and the
> pullup voltage available in microvolts.  But it was promptly converting
> both to millivolts before using them to calculate the thermistor
> resistance.  That conversion unnecessarily hurt the precision of the
> calculation.
>
> For example, take the ncpXXwb473 connected to 5000 mV and pulled down
> through a 47000 ohm resistor.  At 25 C, the resistance of the thermistor
> is 47000 ohms.  The measured voltage will be 2500 mV.  If we measure
> instead 2501 mV, then the calculated resistance will be 46962 ohms --
> a difference of 38 ohms.  So the precision of the resistance estimate
> could be increased by 38X by doing the calculations in microvolts.
>
> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
