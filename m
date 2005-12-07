From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 07 Dec 2005 21:15:26 +0000
Subject: [lm-sensors] [PATCH 2.6.15-rc5-mm1] i2c: i2c-mv64xxx - Abort
Message-Id: <20051207221526.4b0dad1e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051207014449.GA21553@mag.az.mvista.com>
In-Reply-To: <20051207014449.GA21553@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

>  			dev_err(&drv_data->adapter.dev,
> -				"mv64xxx: I2C bus locked\n");
> +				"mv64xxx: I2C bus locked, block: %d,"
> +				" time_left: %d, before: %d, after: %d\n",
> +				drv_data->block, time_left);

Please put the middle space at the end of the first half of the string
rather than the beginning of the second half. Following this arbitrary
rule makes it easier to spot split strings missing their middle
space(s).

The parameter count for dev_err() is also not correct, the string has
four %d and you provide only two values. I'd be surprised it even
compiles.

-- 
Jean Delvare

