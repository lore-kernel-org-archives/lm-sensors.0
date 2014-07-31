From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 31 Jul 2014 06:09:20 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (lm85) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53D9DD90.5060001@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406089751.15290.3.camel@phoenix>
In-Reply-To: <1406089751.15290.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/22/2014 09:29 PM, Axel Lin wrote:
> Use devm_hwmon_device_register_with_groups() to simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
