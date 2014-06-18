From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Jun 2014 14:36:07 +0000
Subject: Re: [lm-sensors] [PATCH RFT] hwmon: (ads7828) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53A1A3D7.2010508@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402990703.1589.1.camel@phoenix>
In-Reply-To: <1402990703.1589.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/17/2014 12:38 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

I reviewed this patch several times now, and it still looks ok to me.
So I queued it for -next to get some exposure.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
