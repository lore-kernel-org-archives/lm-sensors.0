From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 10 Feb 2015 12:21:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Check return value of devm_regmap_init_i2c
Message-Id: <54D9F7B0.70901@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423563847.17306.1.camel@phoenix>
In-Reply-To: <1423563847.17306.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/10/2015 02:24 AM, Axel Lin wrote:
> devm_regmap_init_i2c() can fail, thus add return value checking.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
