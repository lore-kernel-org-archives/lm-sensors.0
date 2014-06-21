From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 21 Jun 2014 17:21:20 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (fam15h_power) Convert to devm_hwmon_device_register_with_group
Message-Id: <53A5BF10.6060203@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403191751.23194.1.camel@phoenix>
In-Reply-To: <1403191751.23194.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/19/2014 08:29 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Looks good to me. Applied to -next to get some test coverage.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
