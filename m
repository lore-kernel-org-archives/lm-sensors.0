From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Sep 2013 18:27:52 +0000
Subject: Re: [lm-sensors] [PATCH 06/12] hwmon: (adt7462) Use error value returned from find_trange_value()
Message-Id: <20130914202752.7cd279d0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379147615-7703-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1379147615-7703-7-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 14 Sep 2013 01:33:29 -0700, Guenter Roeck wrote:
> find_trange_value() returns -ENODEV in case of errors, only to have it
> ignored and replaced with -EINVAL. Make it return -EINVAL and use it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adt7462.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> (...)

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
