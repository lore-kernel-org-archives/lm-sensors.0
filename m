From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jun 2014 02:21:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83l786ng) Report correct minimum fan speed
Message-Id: <53AA323C.3000907@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403658152.18417.0.camel@phoenix>
In-Reply-To: <1403658152.18417.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/24/2014 06:02 PM, Axel Lin wrote:
> Current code is buggy, it shows the current fan speed as minimum fan speed.
> Fix up show_fan_reg macro to correctly report fan and fan_min speed.
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
