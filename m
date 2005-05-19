From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [PATCH] i2c-vid.h: Support for VID to reg conversion
Message-Id: <20050412215315.35934891.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050412163404.GA14857@kroah.com>
In-Reply-To: <20050412163404.GA14857@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

> +static inline int vid_to_reg(int val, int vrm)
> +{
> +
> +        switch (vrm) {
> +
> +        case  0:
> +                return -1;

This one doesn't make much sense to me, as the default case will catch
it with the exact same effect anyway.

> +
> +        case 91:                /* VRM 9.1 */
> +        case 90:                /* VRM 9.0 */
> +                return ((val >= 1100) && (val <= 1850) ?
> +                        ((18500 - val * 10) / 25 + 5) / 10 : -1);
> +
> +        default:
> +                return -1;
> +
> +        }
> +}

Thanks,
-- 
Jean Delvare
