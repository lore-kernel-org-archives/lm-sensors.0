From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Jul 2014 03:59:06 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (lm78) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53D86D8A.7020706@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406090361.15290.7.camel@phoenix>
In-Reply-To: <1406090361.15290.7.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/22/2014 09:39 PM, Axel Lin wrote:
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
