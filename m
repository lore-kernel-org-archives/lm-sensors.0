From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Jul 2014 16:20:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1021) Fix cache problem when writing temperature limits
Message-Id: <53B582E6.3090806@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404398745.15193.1.camel@phoenix>
In-Reply-To: <1404398745.15193.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/03/2014 07:45 AM, Axel Lin wrote:
> The module test script for the adm1021 driver exposes a cache problem
> when writing temperature limits. temp_min and temp_max are expected
> to be stored in milli-degrees C but are stored in degrees C.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied.

Thanks a lot!

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
