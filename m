From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 07 Jun 2006 10:29:38 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4486AA92.5010306@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
>
> Please have a look to store_pwm_enable which has non-trivial locking. 
> I belive it is OK and I tested briefly, but better to be sure.
>

> +static ssize_t
> +store_pwm_enable(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
>   
> +	if (data->pwm_enable[nr] != val) {
>   
I guess *here* is where you mean non-trivial.

why not take the lock here -> instead of in both branches of if ?

> +		if (!val) {
>   
you specifically and knowingly dont protect this call,
and advised us of it in your msg.  It certainly warrants a comment here too.

> +			store_pwm(dev, attr, "255", 3);
>   
and now take the lock.
> +			mutex_lock(&data->update_lock);
> +			data->pwm_enable[nr] = val;
> +		}
> +		else {
>   
repeating, this lock could be hoisted, but for the missing/unstated reason.

> +			mutex_lock(&data->update_lock);
> +			data->pwm_enable[nr] = val;
> +			val--;
> +		}
> +		reg = (reg & ~(11 << W83627EHF_PWM_ENABLE_SHIFT[nr]));
> +		reg |= val << W83627EHF_PWM_ENABLE_SHIFT[nr];
> +		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
> +					reg);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}
> +
>   
:-)

