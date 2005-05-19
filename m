From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <20050326184911.6c840ec5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
In-Reply-To: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Lucky last: it87
> 
> I'm commenting on the second version of the patch.
> (...)
> Rest looks OK to me.

Ooops, missed this:

> -		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
> +		it87_write_value(client, IT87_REG_PWM(nr),
> +				PWM_TO_REG(data->manual_pwm_ctl[nr]));

Don't do that, it doesn't belong there.

Thanks,
-- 
Jean Delvare
