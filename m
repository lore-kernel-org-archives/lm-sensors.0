From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Dec 2005 20:23:45 +0000
Subject: [lm-sensors] [PATCH 1/7] i2c: scx200_acb - whitespace and
Message-Id: <20051219212345.6f3b2fec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191049t5050cd42w82b65f03dd350a7b@mail.gmail.com>
In-Reply-To: <808c8e9d0512191049t5050cd42w82b65f03dd350a7b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> scx200_acb whitespace and comment cleanup.

Looks like you have been over-zealous here. These three types of
changes in this patch are not really wanted:

> -#define NAME "scx200_acb"
> +#define NAME		"scx200_acb"

> -	struct scx200_acb_iface *next;
> -	struct i2c_adapter adapter;
> -	unsigned base;
> -	struct semaphore sem;
> +	struct scx200_acb_iface	*next;
> +	struct i2c_adapter	adapter;
> +	unsigned		base;
> +	struct semaphore	sem;

>  			iface->result = 0;
> -			iface->state = state_idle;
> +			iface->state  = state_idle;

Given that different developers like it differently and there is no
absolute rule for these points, and given that the scx200_acb driver is
consistent with regards to these points, I'd leave the current code as
it is.

All other changes (in this patch) I am fine with.

Thanks,
-- 
Jean Delvare

