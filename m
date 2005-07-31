From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 31 Jul 2005 18:22:57 +0000
Subject: [lm-sensors] Re: [PATCH] i2c-algo-pca -- gracefully handle a busy
Message-Id: <20050731182218.11e80156.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122633085.19718.106.camel@icampbell-debian>
In-Reply-To: <1122633085.19718.106.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

> I've been running with this patch for a while now, and while I've
> never seen it trigger except with buggy hardware I think it is a
> cleaner way to handle a busy bus. I had -EBUSY until about 10 minutes
> ago but -EIO seems to be what most of the existing algo drivers will
> return in the same circumstances.

Fine with me, except for the few coding style issues below.

> --- 2.6.orig/drivers/i2c/algos/i2c-algo-pca.c	2005-07-29 08:38:10.000000000 +0100
> +++ 2.6/drivers/i2c/algos/i2c-algo-pca.c	2005-07-29 11:25:44.000000000 +0100
> (...)
> +	while((state = pca_status(adap)) != 0xf8 && timeout--) {

Space after "while".

> +		msleep(10);
> +	}
> +	if ( state != 0xf8 ) {

No space on the inner side of parentheses.

Thanks,
-- 
Jean Delvare
