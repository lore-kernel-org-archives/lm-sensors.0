From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Jun 2014 14:37:31 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (wm8350) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53A1A42B.30004@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403017928.5292.3.camel@phoenix>
In-Reply-To: <1403017928.5292.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/17/2014 08:12 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Looks good to me. Applied to -next to get exposure.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
