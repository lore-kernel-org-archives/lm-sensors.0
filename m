From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Jul 2015 04:05:35 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: (nct7802) Add autopoint attributes
Message-Id: <55B5AE0F.5030600@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437860750-10339-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1437860750-10339-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Constantine,

On 07/26/2015 04:40 AM, Guenter Roeck wrote:

> Question is if the values above are consistent for you when you reload
> the driver (without updating the pwm values, which I think you did above).
> I am having trouble with both the real target and with my module test code.
> It fails for me with all kernel versions from 3.16 to 4.1 if the regmap
> cache type is set to REGCACHE_RBTREE. I am currently trying to track this down.
>

Confirmed to be a regmap problem with REGCACHE_RBTREE. If a block of registers
is enlarged, the cache bitmap memory size is increased with krealloc().
Unfortunately, krealloc() does not zero out the additional memory, which
means the bitmap indicating which registers are cached includes random values.

I'll submit a patch for that after some more testing. Please resubmit your patch
with the changes I asked for.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
