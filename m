From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 22 Jan 2015 23:16:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] drivers/hwmon/ad7314.c: Do proper sign extension
Message-Id: <54C184B0.7060606@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421966655-16188-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1421966655-16188-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 01/22/2015 02:44 PM, Rasmus Villemoes wrote:
> The comment above (data << 2) >> 2 explains what the intention is: To
> use bit 13 of the 14-bit value data as the sign bit. However, this
> doesn't work due to C's promotion rules. data has type s16, but data
> << 2 has type int. To get sign extension, that expression would have
> to be cast back to an s16 before being shifted (at which point C's
> promotion rules would then kick in again and promote the left operand
> to int). As it stands, both expressions are no-ops for any value of
> data.
>
> Avoid these subtleties by using the existing API for
> this. sign_extend32 works equally well for 8 and 16 bit types.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Good catch. Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
