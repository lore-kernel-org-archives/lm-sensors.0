From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Jul 2014 18:34:52 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (ad7414) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53B2FF4C.9040803@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404225104.17487.4.camel@phoenix>
In-Reply-To: <1404225104.17487.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/01/2014 07:31 AM, Axel Lin wrote:
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
