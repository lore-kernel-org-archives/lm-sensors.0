From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Jul 2014 18:34:19 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (ad7418) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53B2FF2B.5030104@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404225629.17487.8.camel@phoenix>
In-Reply-To: <1404225629.17487.8.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/01/2014 07:40 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Note that I used i2c-stub and a module test script to ensure that
the driver is working. I'll do the same for other i2c drivers
if I don't have the real hardware.

Thanks,
Guenter





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
