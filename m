From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 12:19:19 +0000
Subject: [lm-sensors] [PATCH] I2C W83792D driver 1/3
Message-Id: <f25Bugv8.1122459176.0095350.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050727092431.10185.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050727092431.10185.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

> +/* Addresses to scan */
> +static unsigned short normal_i2c[] = { 0x2c, 0x2f, I2C_CLIENT_END };

I suspect that addresses 0x2d and 0x2e are also possible and missing from
this list.

Also, it seems to me that the end of the patch file is missing?

Thanks,
--
Jean Delvare
