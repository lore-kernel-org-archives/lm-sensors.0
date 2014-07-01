From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Jul 2014 18:32:50 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (ad7418) Avoid forward declaration
Message-Id: <53B2FED2.6030905@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404225548.17487.6.camel@phoenix>
In-Reply-To: <1404225548.17487.6.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/01/2014 07:39 AM, Axel Lin wrote:
> Move ad7418_driver to proper place to avoid forward declaration.
> Also move ad7418_init_client() close to ad7418_probe().
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
