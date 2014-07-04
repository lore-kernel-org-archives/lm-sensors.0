From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 04 Jul 2014 15:16:28 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adm9240) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53B6C54C.1000805@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404396108.4895.13.camel@phoenix>
In-Reply-To: <1404396108.4895.13.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/03/2014 07:01 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
