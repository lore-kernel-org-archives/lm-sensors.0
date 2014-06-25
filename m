From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jun 2014 02:24:32 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (w83l786ng) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53AA32E0.9020506@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403660391.31123.2.camel@phoenix>
In-Reply-To: <1403660391.31123.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/24/2014 06:39 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Applied to -next.

I'd like to get test coverage on this one, but I feel comfortable enough
to give it a try.

On a side note, it appears the chip is long since obsolete, so I wonder
if anyone is still using it.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
