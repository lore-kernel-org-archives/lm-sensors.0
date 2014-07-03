From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Jul 2014 03:58:25 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (gl518sm) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53B4D4E1.5020106@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404352084.29709.3.camel@phoenix>
In-Reply-To: <1404352084.29709.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/02/2014 06:48 PM, Axel Lin wrote:
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
