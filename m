From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240 (2nd try)
Message-Id: <0TTOJxjD.1114675827.5039600.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> >	reg = adm9240_read_value(client, ADM9240_REG_CONFIG);
> >	adm9240_write_value(client, ADM9240_REG_CONFIG,
> >		(reg | 0x01) & 0x7f);
>
> That would fail to start the measurement cycle (...)

How that? Bit 0 will be set to 1, which starts the measurement cycle,
exactly like your previous code did.

> and leave user-space able to assert a hardware interrupt signal,

I don't understand. What do you mean exactly?

> (...) plus it writes zero to bit 7 for what reason?

Because writing 1 instead would reset the chip, and you don't want to do
that, do you?

Thanks,
--
Jean Delvare
