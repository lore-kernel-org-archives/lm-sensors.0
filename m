From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Jul 2014 14:12:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1021) Avoid forward declaration
Message-Id: <53B564CC.4020900@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404395133.4895.1.camel@phoenix>
In-Reply-To: <1404395133.4895.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/03/2014 06:45 AM, Axel Lin wrote:
> Reorder functions to avoid forward declaration.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Hi Axel,

did you write module test scripts for any of those by any chance ?
Just asking, since it would save me some time.

The module test script for the adm1021 driver exposes a cache problem
when writing temperature limits. temp_min and temp_max are expected
to be stored in milli-degrees C but are stored in degrees C.
Feel free to send a patch to fix the problem if you have time.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
