From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 22 Jan 2015 23:16:32 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] drivers/hwmon/adc128d818.c: Do proper sign extension
Message-Id: <54C184D0.6080509@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421966655-16188-1-git-send-email-linux@rasmusvillemoes.dk> <1421966655-16188-2-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1421966655-16188-2-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 01/22/2015 02:44 PM, Rasmus Villemoes wrote:
> data->temp[index] has type s16. Because of C's promotion rules,
> (data->temp[index] << 7) >> 7 is exactly the same as
> data->temp[index]. The intention was to use bit 8 as a sign bit, so do
> that using the existing API.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
