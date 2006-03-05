From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Mar 2006 17:32:27 +0000
Subject: [lm-sensors] [PATCH 2.6.15-rc5] hwmon: add required idr locking
Message-Id: <20060305183227.5deb7c23.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060305152435.GA7990@jupiter.solarsys.private>
In-Reply-To: <20060305152435.GA7990@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> Add required locking around idr_ routines, retry the idr_pre_get/idr_get_new
> pair properly, and sprinkle in some likely/unlikely for good measure.
> 
> (Lack of idr locking didn't hurt when all callers were I2C clients, as the
> i2c-core serialized for us anyway.  Now that we have non I2C hwmon drivers,
> this is truly necessary.)
> 
> This patch should be considered for 2.6.16.

Thanks for reporting the problem and proposing a fix. It's all correct
as far as I can tell, but I'd still have a few comments:

> -	if (idr_get_new(&hwmon_idr, NULL, &id) < 0)
> +	spin_lock(&idr_lock);
> +	err = idr_get_new(&hwmon_idr, NULL, &id);
> +	spin_unlock(&idr_lock);
> +
> +	if (unlikely(err = -EAGAIN))
> +		goto again;
> +	else if (unlikely(err))
>  		return ERR_PTR(-ENOMEM);

It has just occured to me that the error value we are returning is not
correct. Why -ENOMEM? As far as I know, idr_get_new does not allocate
memory, by design, so it's probably the more inaccurate error value we
could return.

Why don't we just return ERR_PTR(err) instead?

I realize that this isn't strictly related with your patch, the old code
returned just the same, but while we're here changing that code...

> -	if (IS_ERR(cdev))
> +	if (unlikely(IS_ERR(cdev))) {

IS_ERR() already includes an unlikely(), so this is redundant.

And you're right, let's try to get that patch in 2.6.16.

Thanks,
-- 
Jean Delvare

