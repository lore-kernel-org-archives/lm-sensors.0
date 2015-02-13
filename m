From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Feb 2015 05:09:01 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (ibmpex) Allow format string checking
Message-Id: <54DD86ED.6010500@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423750517-26439-1-git-send-email-linux@rasmusvillemoes.dk> <1423750517-26439-3-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1423750517-26439-3-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 02/12/2015 06:15 AM, Rasmus Villemoes wrote:
> The only difference between the three power_sensor_name_templates is
> whether there is a suffix of "", "_lowest" or "_highest". We might as
> well pull those into an array and use a literal format string,
> allowing gcc to do type checking of the arguments to
> sprintf. Incidentially, the same three suffixes are used in the
> temp_sensor_name_templates case, so we end up eliminating one static
> array.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to -next after fixing 'line over 80 characters' checkpatch warning.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
