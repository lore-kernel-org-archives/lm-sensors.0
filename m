From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [PATCH] ALI1563 SMBus driver fix
Message-Id: <20050412214932.2c7df487.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ruik,

> -/**
> +/*
>   *	i2c-ali1563.c - i2c driver for the ALi 1563 Southbridge
>   *
>   *	Copyright (C) 2004 Patrick Mochel

Please avoid noise in patches, it doesn't help review.

> +	/* device error - probably missing ACK, from autdetection I2C_QUICK */
> +	if (data & HST_STS_DEVERR) {
> +		dev_dbg(&a->dev, "Device error!\n");
> +	}

I don't like this. If this "error" is normal for I2C_QUICK, then don't
issue any message and return 0 in this case, and issue an *error*, not
debug, message in the other cases.

As far as I can see, this means adding a second parameter to
ali1563_transaction, but I don't think this is a problem.

>  	/* Write the command register */
> +
>  	switch(size) {

Noise :p

I'm otherwise fine with your patch, thanks a lot for your great
investigation work on this.

-- 
Jean Delvare
