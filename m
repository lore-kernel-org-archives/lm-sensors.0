From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Apr 2014 13:23:15 +0000
Subject: Re: [lm-sensors] [PATCH 0/8] hwmon: Remove unnecessary OOM messages
Message-Id: <535FA7C3.9040802@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <001901cf6381$d43aad60$7cb00820$%han@samsung.com>
In-Reply-To: <001901cf6381$d43aad60$7cb00820$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/29/2014 01:05 AM, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. For example,
> k.alloc and v.alloc failures use dump_stack().
>
> Jingoo Han (8):
>        hwmon: (f71805f) remove unnecessary OOM messages
>        hwmon: (ibmpex) remove unnecessary OOM messages
>        hwmon: (lm93) remove unnecessary OOM messages
>        hwmon: (max1111) remove unnecessary OOM messages
>        hwmon: (max197) remove unnecessary OOM messages
>        hwmon: (pc87427) remove unnecessary OOM messages
>        hwmon: (s3c-hwmon) remove unnecessary OOM messages
>        hwmon: (vt1211) remove unnecessary OOM messages
>

Series applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
