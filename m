From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Jul 2014 03:28:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads1015) Fix off-by-one for valid channel index checking
Message-Id: <53D8664F.9010304@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406690032.6636.1.camel@phoenix>
In-Reply-To: <1406690032.6636.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/29/2014 08:13 PM, Axel Lin wrote:
> Current code uses channel as array index, so the valid channel value is
> 0 .. ADS1015_CHANNELS - 1.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Amazing. How do you find this stuff ?

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
