From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 25 Jul 2014 04:31:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (pwm-fan) Remove duplicate dev_set_drvdata call
Message-Id: <53D1DD9F.3030401@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406257946.9778.1.camel@phoenix>
In-Reply-To: <1406257946.9778.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/24/2014 08:12 PM, Axel Lin wrote:
> The dev_set_drvdata() call is equivalent to the platform_set_drvdata() call in
> next line.
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
