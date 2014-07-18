From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Jul 2014 14:49:19 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (smsc47m1) Avoid forward declaration
Message-Id: <53C933EF.7020807@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405595736.13586.6.camel@phoenix>
In-Reply-To: <1405595736.13586.6.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/17/2014 04:15 AM, Axel Lin wrote:
> Reorder functions to avoid forward declaration.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

No functional change, so while I can not easily test it beyond
compilation, is is low enough risk. Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
