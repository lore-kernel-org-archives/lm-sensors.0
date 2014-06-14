From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Jun 2014 13:14:57 +0000
Subject: Re: [lm-sensors] [RFT][PATCH v2] hwmon: (twl4030-madc-hwmon) Convert to devm_hwmon_device_register_w
Message-Id: <539C4AD1.2040607@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402727604.13807.1.camel@phoenix>
In-Reply-To: <1402727604.13807.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/13/2014 11:33 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Looks correct to me, and makes the driver work, so I'll queue it up for -next.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
