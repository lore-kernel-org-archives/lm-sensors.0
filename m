From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Jun 2006 11:47:15 +0000
Subject: [lm-sensors] [PATCH] i2c: fix scx200_acb block transactions
Message-Id: <20060611134715.3ec0724c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060608182358.a3f24450.khali@linux-fr.org>
In-Reply-To: <20060608182358.a3f24450.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

Quoting myself:
> This would be a better fix. I would much appreciate if someone with an
> scx200_acb bus could give it some testing, just in case. In particular
> testing the various modes of i2cdump on an EEPROM would be useful.
> 
> 
> The scx200_acb i2c bus driver pretends to support SMBus block
> transactions, but in fact it implements the more simple I2C block
> transactions. Additionally, it lacks sanity checks on the length
> of the block transactions, which could lead to a buffer overrun.

As discussed earlier on IRC, please hold on with this patch as well. It
is correct but uncovers older bugs in the scx200_acb driver state
machine. We need to fix them before the functionality change itself is
safe.

No big deal if it doesn't make it in 2.6.17, after all the bugs have
been there for a very long time now and they are just being discovered
and reported now so better wait a few more months and make sure we come
up with a complete fix. After all, that's exactly what -stable was made
for.

Thanks,
-- 
Jean Delvare

