From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH 2.6] i2c-algo-bit should support I2C_FUNC_I2C
Message-Id: <M01spOS7.1102416169.2778980.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101807766.3215.103.camel@icampbell-debian>
In-Reply-To: <1101807766.3215.103.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ian,

> - printk(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
> + DEB1(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );

Doesn't look OK to me. Either this is an error and it has to be
displayed regardless of DEBUG being enabled or not, or it is a debugging
info and it should use KERN_DEBUG instead of KERN_ERR. In the latter
case, I can already hear Greg suggest you should use pr_debug or even
dev_dbg instead of printk.

(Otherwise I am fine with the I2C_FUNC_I2C additions, even if I did not
look at the datasheets.)

Thanks,
--
Jean Delvare
