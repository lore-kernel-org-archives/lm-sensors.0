From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 21 Jan 2015 14:08:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: abx500: fix format string warnings
Message-Id: <54BFB2D8.6080700@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150121080322.GA26811@ubuntu>
In-Reply-To: <20150121080322.GA26811@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Asaf Vertz <asaf.vertz@tandemg.com>, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 01/21/2015 12:03 AM, Asaf Vertz wrote:
> Fixed the following warnings (reported by cppcheck):
> [drivers/hwmon/abx500.c:224]: (warning) %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> [drivers/hwmon/abx500.c:233]: (warning) %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
> [drivers/hwmon/abx500.c:242]: (warning) %ld in format string (no. 1)
> requires 'long' but the argument type is 'unsigned long'.
>
> Signed-off-by: Asaf Vertz <asaf.vertz@tandemg.com>
> ---

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
