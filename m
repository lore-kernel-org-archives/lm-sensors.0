From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Dec 2005 21:40:20 +0000
Subject: [lm-sensors] [PATCH 3/7] i2c: scx200_acb - refactor and
Message-Id: <20051219224020.5fdb3844.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191052u2479cc66w87148f04af51f564@mail.gmail.com>
In-Reply-To: <808c8e9d0512191052u2479cc66w87148f04af51f564@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> scx200_acb refactor/simplify code (no functional changes).

> +		dev_dbg(&iface->adapter.dev, "negative ack in state %s\n",
> (...)
> -	dev_dbg(&iface->adapter.dev, "negative acknowledge in state %s\n",

Functional change, you changed the debug message ;)

>  	if (!iface) {
>  		printk(KERN_ERR NAME ": can't allocate memory\n");
> -		rc = -ENOMEM;
> -		goto errout;
> +		return -ENOMEM;
>  	}

Some people seem to prefer single exit point, so you could preserve the
errout label right before the trailing return, and keep that code.

-- 
Jean Delvare

