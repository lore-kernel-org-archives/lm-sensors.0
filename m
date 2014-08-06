From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 06 Aug 2014 02:41:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (hih6130) Fix missing hih6130->write_length setting
Message-Id: <53E195DF.3000103@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407283610.4924.3.camel@phoenix>
In-Reply-To: <1407283610.4924.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/05/2014 05:06 PM, Axel Lin wrote:
> The hih6130->write_length setting was accidently removed by commit
> ebc6b9383f3e "hwmon: (hih6130) Convert to devm_hwmon_device_register_with_groups",
> fix it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
