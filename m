From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 02 Jul 2014 00:54:54 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: (adm1029) Ensure the fan_div cache is updated in set_fan_div
Message-Id: <53B3585E.6070200@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404260995.7829.5.camel@phoenix>
In-Reply-To: <1404260995.7829.5.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/01/2014 05:29 PM, Axel Lin wrote:
> Writing to fanX_div does not clear the cache. As a result, reading
> from fanX_div may return the old value for up to two seconds
> after writing a new value.
>
> This patch ensures the fan_div cache is updated in set_fan_div().
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Sorry, I have a typo in previous patch s/fad_div/fan_div/. So here is a resend.

fad_div is more fun though ;-)

I sent out the same patch half an hour ago, but I'll take yours for the second sign-off.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
