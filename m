From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Feb 2015 05:08:14 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (coretemp) Allow format checking
Message-Id: <54DD86BE.4000408@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423750517-26439-1-git-send-email-linux@rasmusvillemoes.dk> <1423750517-26439-2-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1423750517-26439-2-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 02/12/2015 06:15 AM, Rasmus Villemoes wrote:
> By extracting the only part that differs we can allow static checking
> of the format string, and possibly save a little .rodata.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to -next after fixing multi-line alignment.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
